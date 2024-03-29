
use std::sync::{Mutex, OnceLock};
use std::cell::Cell;

enum CompileMode { Tokenize, Parse, Typecheck, Compile }

use lambda_mountain::*;

static mut CONFIG_MODE: CompileMode = CompileMode::Compile;
static mut CONFIG_STRICT: bool = true;
static mut CONFIG_PREPROCESS: bool = true;
static mut PARSED_PROGRAM: Option<AST> = None;
static CONFIG_TARGET: OnceLock<Mutex<Cell<String>>> = OnceLock::new();

fn config_target<'a>() -> &'a Mutex<Cell<String>> {
   CONFIG_TARGET.get_or_init(|| Mutex::new(Cell::new("tmp.s".to_string())))
}

fn main() {
   let mut inputs = Vec::new();
   let mut set_target = false;
   for arg in std::env::args() {
      if set_target { config_target().lock().unwrap().set(arg); }
      else if arg=="--tokenize" {unsafe{ CONFIG_MODE = CompileMode::Tokenize; }}
      else if arg=="--parse" {unsafe{ CONFIG_MODE = CompileMode::Parse; }}
      else if arg=="--typecheck" {unsafe{ CONFIG_MODE = CompileMode::Typecheck; }}
      else if arg=="--compile" {unsafe{ CONFIG_MODE = CompileMode::Compile; }}
      else if arg=="--strict" {unsafe{ CONFIG_STRICT = true; }}
      else if arg=="--gradual" {unsafe{ CONFIG_STRICT = false; }}
      else if arg=="--noprep" {unsafe{ CONFIG_PREPROCESS = false; }}
      else if arg=="-o" { set_target = true; }
      else { inputs.push(arg); }
   }

   for input in inputs { unsafe { match CONFIG_MODE {
      CompileMode::Compile => { parse_program(tokenize_file(&input)); }
      CompileMode::Parse => { parse_program(tokenize_file(&input)); }
      CompileMode::Typecheck => { parse_program(tokenize_file(&input)); }
      CompileMode::Tokenize => { tokenize_file(&input).print(); }
   }}}

   unsafe { if CONFIG_PREPROCESS {
      PARSED_PROGRAM = Some(preprocess(PARSED_PROGRAM.clone().expect("PARSED_PROGRAM was Corrupt")));
   }}
   unsafe { if CONFIG_STRICT {
      typecheck(PARSED_PROGRAM.clone().expect("PARSED_PROGRAM was Corrupt"));
   }}

   unsafe { match CONFIG_MODE {
      CompileMode::Compile => { assemble(PARSED_PROGRAM.clone().expect("PARSED_PROGRAM was Corrupt")); }
      CompileMode::Parse => { PARSED_PROGRAM.clone().expect("PARSED_PROGRAM was Corrupt").print(); }
      CompileMode::Typecheck => { PARSED_PROGRAM.clone().expect("PARSED_PROGRAM was Corrupt").print_ascripted(); }
      _ => {}
   }}
}
