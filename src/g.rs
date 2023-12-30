/*

Copyright 2023 - Andrew Johnson

This code and all related intellectual property is available under the terms of
the attached permissive MIT license. This license is intended only to protect
the future development of the project while otherwise allowing people to use
the code and IP as they would like. Please, just be nice.

G: A Basic Codegen

*/

use crate::*;
use punc::*;

pub fn compile(_cfg: &str, ctx: &S) {
  let helpers = parse_file("stdlib/untyped.lm");
  let ctx = kv_merge(&helpers, &ctx);
  for (k,v) in kv_iter(&ctx) {
     //if is helper, ignore
     if k.to_string().starts_with("::") {}
     //if is symbol, reduce and compile
     else {
        let safe = app(
           variable("::safe-compile-expression"),
           app(
              v,
              typ("Block"),
           )
        );
        let fragment = ctx_eval(&ctx, &safe);
        println!("g::compile fragment {} = {}", k, fragment);
     }
  }
  unimplemented!("g::compile")
}
