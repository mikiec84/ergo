(*
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

open ErgoUtil

let patch_cto_extension f =
  begin try
    let extension = Filename.extension f in
    if extension = ".cto"
    then
      (Filename.chop_suffix f ".cto") ^ ".ctoj"
    else f
  with
  | _ -> f
  end

let patch_argv argv =
  Array.map patch_cto_extension argv

let wrap_error e =
  begin match e with
  | Ergo_Error error ->
      Printf.eprintf "%s\n" (string_of_error error); exit 2
  | exn ->
      Printf.eprintf "%s\n" (string_of_error (ergo_system_error (Printexc.to_string exn))); exit 2
  end

let () =
  begin try
    Ergoc.main (fun x -> x) (patch_argv Sys.argv)
  with
  | e ->
      wrap_error e
  end

