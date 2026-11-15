import bindgen::bg;
import bindgen::bgstr;
import std::io;
import std::io::file;

fn void main() {
  File? output_file = file::open("references/generated_ftxui_bindings.c3i", "w");
  if (catch err = output_file) {
    io::eprintfn("Error while opening output file: %s", err);
    return;
  }
  if (catch err = bg::translate_header("ftxui-c/ftxui_c_api.h", {
    .out_file = output_file,
    .module_name = "ftxui::ffi",
  }, {
    .type = fn String(String name, Allocator allocator) {
      return bgstr::snake_to_pascal(
        name.strip_prefix("ftxui_").strip_suffix("_t"),
        allocator
      );
    },
    .func = fn String(String name, Allocator allocator) {
      return name.strip_prefix("ftxui_");
    },
  })) {
    io::eprintfn("Error while translating header: %s", err);
    return;
  }
}
