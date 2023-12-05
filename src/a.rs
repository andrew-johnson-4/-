/*

Copyright 2023 - Andrew Johnson

This code and all related intellectual property is available under the terms of
the attached permissive MIT license. This license is intended only to protect
the future development of the project while otherwise allowing people to use
the code and IP as they would like. Please, just be nice.

A: An S-Expression based AST

*/

use regex::Regex;
use std::collections::HashMap;
use crate::*;

pub fn literal(s: &str) -> S {
   s_cons( s_atom("literal"), s_atom(s) )
}

pub fn variable(s: &str) -> S {
   s_cons( s_atom("variable"), s_atom(s) )
}

pub fn lambda(l: S, r: S) -> S {
   s_cons( s_atom("lambda"), s_cons(l,r) )
}

pub fn regex(r: &str) -> S {
   s_cons( s_atom("regex"), s_atom(r) )
}

pub fn list(s: &[S]) -> S {
   let mut tail = s_nil();
   for x in s.iter().rev() {
      tail = s_cons( x.clone(), tail );
   }
   tail
}

pub fn kv(s: &[(S,S)]) -> S {
   s_nil()
}

fn destructure(ctx: &mut HashMap<String,S>, pattern: S, value: S) -> bool {
   if pattern==value { return true; }
   if !is_cons(&pattern) { return false; }
   if head(&pattern)==s_atom("variable") {
      let k = tail(&pattern).to_string();
      ctx.insert( k, value );
      return true;
   }
   if !is_cons(&value) { return false; }
   if is_atom(&head(&pattern)) && head(&pattern).to_string()=="lambda" {
      return false;
   }
   if is_atom(&head(&pattern)) && head(&pattern).to_string()=="regex" {
      if !is_atom(&head(&value)) || head(&value).to_string()!="literal" { return false; }
      let value = tail(&value).to_string();
      let re = Regex::new(&tail(&pattern).to_string()).unwrap();
      return if let Some(c) = re.captures(&value) {
         for (ci,cm) in c.iter().enumerate() {
            if let Some(m) = cm.map(|m| m.as_str()) {
               let k = "{".to_string() + &format!("{}",ci) + "}";
               ctx.insert( k, literal(m) );
            }
         }
         true
      } else { false }
   }
   destructure(ctx, head(&pattern), head(&value)) &&
   destructure(ctx, tail(&pattern), tail(&value))
}
fn restructure(ctx: &HashMap<String,S>, value: S) -> S {
   if !is_cons(&value) { return value; }
   if head(&value)==s_atom("variable") {
      let k = tail(&value).to_string();
      return if let Some(v) = ctx.get(&k) { v.clone() }
      else { value };
   }
   value
}
pub fn map(lhs: S, v: S, rhs: S) -> S {
   let mut ctx = HashMap::new();
   if destructure(&mut ctx, lhs, v) {
      restructure(&ctx, rhs)
   } else { s_nil() }
}
