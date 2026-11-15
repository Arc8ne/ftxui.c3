module ftxui;

typedef ComponentHandle = void*;
typedef ElementHandle = void*;
typedef ColorHandle = void*;
typedef CapturedMouseHandle = void*;
typedef EventHandle = void*;
typedef LoopHandle = void*;
typedef LinearGradientHandle = void*;
typedef CanvasHandle = void*;
typedef TableHandle = void*;
typedef TableSelectionHandle = void*;
<* This handle wraps a mutable `std::string` for use with `Input` components. *>
typedef MutableCppStdStringHandle = void*;
typedef BoxHandle = void*;

alias RenderCallback = fn ElementHandle(void* userdata);
alias Callback = fn void(void* userdata);
alias PredicateCallback = fn bool(void* userdata);
alias Destructor = fn void(void* userdata);
alias EasingFunction = fn float(float progress);

constdef EasingFunctionType : CInt {
  FTXUI_EASING_LINEAR = 0,
  FTXUI_EASING_QUADRATIC_IN = 1,
  FTXUI_EASING_QUADRATIC_OUT = 2,
  FTXUI_EASING_QUADRATIC_IN_OUT = 3,
  FTXUI_EASING_CUBIC_IN = 4,
  FTXUI_EASING_CUBIC_OUT = 5,
  FTXUI_EASING_CUBIC_IN_OUT = 6,
  FTXUI_EASING_QUARTIC_IN = 7,
  FTXUI_EASING_QUARTIC_OUT = 8,
  FTXUI_EASING_QUARTIC_IN_OUT = 9,
  FTXUI_EASING_QUINTIC_IN = 10,
  FTXUI_EASING_QUINTIC_OUT = 11,
  FTXUI_EASING_QUINTIC_IN_OUT = 12,
  FTXUI_EASING_SINE_IN = 13,
  FTXUI_EASING_SINE_OUT = 14,
  FTXUI_EASING_SINE_IN_OUT = 15,
  FTXUI_EASING_CIRCULAR_IN = 16,
  FTXUI_EASING_CIRCULAR_OUT = 17,
  FTXUI_EASING_CIRCULAR_IN_OUT = 18,
  FTXUI_EASING_EXPONENTIAL_IN = 19,
  FTXUI_EASING_EXPONENTIAL_OUT = 20,
  FTXUI_EASING_EXPONENTIAL_IN_OUT = 21,
  FTXUI_EASING_ELASTIC_IN = 22,
  FTXUI_EASING_ELASTIC_OUT = 23,
  FTXUI_EASING_ELASTIC_IN_OUT = 24,
  FTXUI_EASING_BACK_IN = 25,
  FTXUI_EASING_BACK_OUT = 26,
  FTXUI_EASING_BACK_IN_OUT = 27,
  FTXUI_EASING_BOUNCE_IN = 28,
  FTXUI_EASING_BOUNCE_OUT = 29,
  FTXUI_EASING_BOUNCE_IN_OUT = 30
}
constdef BorderStyle : CInt {
  FTXUI_BORDER_STYLE_LIGHT = 0,
  FTXUI_BORDER_STYLE_DASHED = 1,
  FTXUI_BORDER_STYLE_HEAVY = 2,
  FTXUI_BORDER_STYLE_DOUBLE = 3,
  FTXUI_BORDER_STYLE_ROUNDED = 4,
  FTXUI_BORDER_STYLE_EMPTY = 5
}

constdef TerminalColor : CInt {
  FTXUI_TERMINAL_COLOR_PALETTE1 = 0,
  FTXUI_TERMINAL_COLOR_PALETTE16 = 1,
  FTXUI_TERMINAL_COLOR_PALETTE256 = 2,
  FTXUI_TERMINAL_COLOR_TRUE_COLOR = 3
}

struct Quirks {
  bool block_characters;
  bool cursor_hiding;
  bool component_ascii;
  TerminalColor color_support;
}

module ftxui::component::app;
typedef AppHandle = void*;
extern fn AppHandle create_fullscreen() @cname("ftxui_app_create_fullscreen");
extern fn AppHandle create_fit_component() @cname("ftxui_app_create_fit_component");
extern fn AppHandle create_terminal_output() @cname("ftxui_app_create_terminal_output");
extern fn AppHandle create_fixed_size(CInt width, CInt height) @cname("ftxui_app_create_fixed_size");
extern fn AppHandle create_fullscreen_primary_screen() @cname("ftxui_app_create_fullscreen_primary_screen");
extern fn AppHandle create_fullscreen_alternate_screen() @cname("ftxui_app_create_fullscreen_alternate_screen");
extern fn void AppHandle.loop(self, ComponentHandle component) @cname("ftxui_app_loop");
extern fn void AppHandle.exit(self) @cname("ftxui_app_exit");
extern fn void AppHandle.free(self) @cname("ftxui_app_destroy");
extern fn void AppHandle.track_mouse(self, bool enable) @cname("ftxui_app_track_mouse");
extern fn void AppHandle.handle_piped_input(self, bool enable) @cname("ftxui_app_handle_piped_input");
extern fn void AppHandle.force_handle_ctrl_c(self, bool force) @cname("ftxui_app_force_handle_ctrl_c");
extern fn void AppHandle.force_handle_ctrl_z(self, bool force) @cname("ftxui_app_force_handle_ctrl_z");
alias UserdataCallback = fn void(void* userdata);
extern fn void AppHandle.post(self, UserdataCallback callback, void* userdata, Destructor destructor) @cname("ftxui_app_post");
extern fn void AppHandle.post_event(self, EventHandle event) @cname("ftxui_app_post_event");
extern fn void AppHandle.with_restored_io(self, UserdataCallback callback, void* userdata, Destructor destructor) @cname("ftxui_app_with_restored_io");
extern fn AppHandle _app_active() @cname("ftxui_app_active");
excuse NO_CURRENTLY_RUNNING_APP;
fn AppHandle? active() {
  AppHandle current = _app_active();
  if ((void*)current == null) return NO_CURRENTLY_RUNNING_APP~;
  return current;
}
extern fn void AppHandle.request_animation_frame(self) @cname("ftxui_app_request_animation_frame");
extern fn ZString AppHandle.terminal_name(self) @cname("ftxui_app_terminal_name");
extern fn CInt AppHandle.terminal_version(self) @cname("ftxui_app_terminal_version");
extern fn ZString AppHandle.terminal_emulator_name(self) @cname("ftxui_app_terminal_emulator_name");
extern fn ZString AppHandle.terminal_emulator_version(self) @cname("ftxui_app_terminal_emulator_version");
extern fn CInt* AppHandle.terminal_capabilities(self, CInt* count) @cname("ftxui_app_terminal_capabilities");
extern fn CapturedMouseHandle AppHandle.capture_mouse(self) @cname("ftxui_app_capture_mouse");
extern fn void CapturedMouseHandle.free(self) @cname("ftxui_captured_mouse_destroy");
extern fn void AppHandle.selection_change(self, UserdataCallback callback, void* userdata, Destructor destructor) @cname("ftxui_app_selection_change");
extern fn ZString AppHandle.get_selection(self) @cname("ftxui_app_get_selection");

module ftxui::screen::terminal;
extern fn CInt width() @cname("ftxui_terminal_width");
extern fn CInt height() @cname("ftxui_terminal_height");
extern fn void set_fallback_size(CInt width, CInt height) @cname("ftxui_terminal_set_fallback_size");
extern fn TerminalColor color_support() @cname("ftxui_terminal_color_support");
extern fn void set_color_support(TerminalColor color) @cname("ftxui_terminal_set_color_support");
extern fn Quirks get_quirks() @cname("ftxui_terminal_get_quirks");
extern fn void set_quirks(Quirks quirks) @cname("ftxui_terminal_set_quirks");

module ftxui::component::loop;
import ftxui::component::app;
extern fn LoopHandle create(AppHandle app, ComponentHandle component) @cname("ftxui_loop_create");
extern fn bool LoopHandle.has_quitted(self) @cname("ftxui_loop_has_quitted");
extern fn void LoopHandle.run_once(self) @cname("ftxui_loop_run_once");
extern fn void LoopHandle.run_once_blocking(self) @cname("ftxui_loop_run_once_blocking");
extern fn void LoopHandle.free(self) @cname("ftxui_loop_destroy");

module ftxui::screen::color;
constdef Palette1 : CInt {
  FTXUI_PALETTE1_DEFAULT = 0
}
constdef Palette16 : CInt {
  FTXUI_PALETTE16_BLACK = 0,
  FTXUI_PALETTE16_RED = 1,
  FTXUI_PALETTE16_GREEN = 2,
  FTXUI_PALETTE16_YELLOW = 3,
  FTXUI_PALETTE16_BLUE = 4,
  FTXUI_PALETTE16_MAGENTA = 5,
  FTXUI_PALETTE16_CYAN = 6,
  FTXUI_PALETTE16_GRAY_LIGHT = 7,
  FTXUI_PALETTE16_GRAY_DARK = 8,
  FTXUI_PALETTE16_RED_LIGHT = 9,
  FTXUI_PALETTE16_GREEN_LIGHT = 10,
  FTXUI_PALETTE16_YELLOW_LIGHT = 11,
  FTXUI_PALETTE16_BLUE_LIGHT = 12,
  FTXUI_PALETTE16_MAGENTA_LIGHT = 13,
  FTXUI_PALETTE16_CYAN_LIGHT = 14,
  FTXUI_PALETTE16_WHITE = 15
}
constdef Palette256 : CInt {
  FTXUI_PALETTE256_AQUAMARINE1 = 122,
  FTXUI_PALETTE256_AQUAMARINE1BIS = 86,
  FTXUI_PALETTE256_AQUAMARINE3 = 79,
  FTXUI_PALETTE256_BLUE1 = 21,
  FTXUI_PALETTE256_BLUE3 = 19,
  FTXUI_PALETTE256_BLUE3BIS = 20,
  FTXUI_PALETTE256_BLUEVIOLET = 57,
  FTXUI_PALETTE256_CADETBLUE = 72,
  FTXUI_PALETTE256_CADETBLUEBIS = 73,
  FTXUI_PALETTE256_CHARTREUSE1 = 118,
  FTXUI_PALETTE256_CHARTREUSE2 = 112,
  FTXUI_PALETTE256_CHARTREUSE2BIS = 82,
  FTXUI_PALETTE256_CHARTREUSE3 = 70,
  FTXUI_PALETTE256_CHARTREUSE3BIS = 76,
  FTXUI_PALETTE256_CHARTREUSE4 = 64,
  FTXUI_PALETTE256_CORNFLOWERBLUE = 69,
  FTXUI_PALETTE256_CORNSILK1 = 230,
  FTXUI_PALETTE256_CYAN1 = 51,
  FTXUI_PALETTE256_CYAN2 = 50,
  FTXUI_PALETTE256_CYAN3 = 43,
  FTXUI_PALETTE256_DARKBLUE = 18,
  FTXUI_PALETTE256_DARKCYAN = 36,
  FTXUI_PALETTE256_DARKGOLDENROD = 136,
  FTXUI_PALETTE256_DARKGREEN = 22,
  FTXUI_PALETTE256_DARKKHAKI = 143,
  FTXUI_PALETTE256_DARKMAGENTA = 90,
  FTXUI_PALETTE256_DARKMAGENTABIS = 91,
  FTXUI_PALETTE256_DARKOLIVEGREEN1 = 191,
  FTXUI_PALETTE256_DARKOLIVEGREEN1BIS = 192,
  FTXUI_PALETTE256_DARKOLIVEGREEN2 = 155,
  FTXUI_PALETTE256_DARKOLIVEGREEN3 = 107,
  FTXUI_PALETTE256_DARKOLIVEGREEN3BIS = 113,
  FTXUI_PALETTE256_DARKOLIVEGREEN3TER = 149,
  FTXUI_PALETTE256_DARKORANGE = 208,
  FTXUI_PALETTE256_DARKORANGE3 = 130,
  FTXUI_PALETTE256_DARKORANGE3BIS = 166,
  FTXUI_PALETTE256_DARKRED = 52,
  FTXUI_PALETTE256_DARKREDBIS = 88,
  FTXUI_PALETTE256_DARKSEAGREEN = 108,
  FTXUI_PALETTE256_DARKSEAGREEN1 = 158,
  FTXUI_PALETTE256_DARKSEAGREEN1BIS = 193,
  FTXUI_PALETTE256_DARKSEAGREEN2 = 151,
  FTXUI_PALETTE256_DARKSEAGREEN2BIS = 157,
  FTXUI_PALETTE256_DARKSEAGREEN3 = 115,
  FTXUI_PALETTE256_DARKSEAGREEN3BIS = 150,
  FTXUI_PALETTE256_DARKSEAGREEN4 = 65,
  FTXUI_PALETTE256_DARKSEAGREEN4BIS = 71,
  FTXUI_PALETTE256_DARKSLATEGRAY1 = 123,
  FTXUI_PALETTE256_DARKSLATEGRAY2 = 87,
  FTXUI_PALETTE256_DARKSLATEGRAY3 = 116,
  FTXUI_PALETTE256_DARKTURQUOISE = 44,
  FTXUI_PALETTE256_DARKVIOLET = 128,
  FTXUI_PALETTE256_DARKVIOLETBIS = 92,
  FTXUI_PALETTE256_DEEPPINK1 = 198,
  FTXUI_PALETTE256_DEEPPINK1BIS = 199,
  FTXUI_PALETTE256_DEEPPINK2 = 197,
  FTXUI_PALETTE256_DEEPPINK3 = 161,
  FTXUI_PALETTE256_DEEPPINK3BIS = 162,
  FTXUI_PALETTE256_DEEPPINK4 = 125,
  FTXUI_PALETTE256_DEEPPINK4BIS = 89,
  FTXUI_PALETTE256_DEEPPINK4TER = 53,
  FTXUI_PALETTE256_DEEPSKYBLUE1 = 39,
  FTXUI_PALETTE256_DEEPSKYBLUE2 = 38,
  FTXUI_PALETTE256_DEEPSKYBLUE3 = 31,
  FTXUI_PALETTE256_DEEPSKYBLUE3BIS = 32,
  FTXUI_PALETTE256_DEEPSKYBLUE4 = 23,
  FTXUI_PALETTE256_DEEPSKYBLUE4BIS = 24,
  FTXUI_PALETTE256_DEEPSKYBLUE4TER = 25,
  FTXUI_PALETTE256_DODGERBLUE1 = 33,
  FTXUI_PALETTE256_DODGERBLUE2 = 27,
  FTXUI_PALETTE256_DODGERBLUE3 = 26,
  FTXUI_PALETTE256_GOLD1 = 220,
  FTXUI_PALETTE256_GOLD3 = 142,
  FTXUI_PALETTE256_GOLD3BIS = 178,
  FTXUI_PALETTE256_GREEN1 = 46,
  FTXUI_PALETTE256_GREEN3 = 34,
  FTXUI_PALETTE256_GREEN3BIS = 40,
  FTXUI_PALETTE256_GREEN4 = 28,
  FTXUI_PALETTE256_GREENYELLOW = 154,
  FTXUI_PALETTE256_GREY0 = 16,
  FTXUI_PALETTE256_GREY100 = 231,
  FTXUI_PALETTE256_GREY11 = 234,
  FTXUI_PALETTE256_GREY15 = 235,
  FTXUI_PALETTE256_GREY19 = 236,
  FTXUI_PALETTE256_GREY23 = 237,
  FTXUI_PALETTE256_GREY27 = 238,
  FTXUI_PALETTE256_GREY3 = 232,
  FTXUI_PALETTE256_GREY30 = 239,
  FTXUI_PALETTE256_GREY35 = 240,
  FTXUI_PALETTE256_GREY37 = 59,
  FTXUI_PALETTE256_GREY39 = 241,
  FTXUI_PALETTE256_GREY42 = 242,
  FTXUI_PALETTE256_GREY46 = 243,
  FTXUI_PALETTE256_GREY50 = 244,
  FTXUI_PALETTE256_GREY53 = 102,
  FTXUI_PALETTE256_GREY54 = 245,
  FTXUI_PALETTE256_GREY58 = 246,
  FTXUI_PALETTE256_GREY62 = 247,
  FTXUI_PALETTE256_GREY63 = 139,
  FTXUI_PALETTE256_GREY66 = 248,
  FTXUI_PALETTE256_GREY69 = 145,
  FTXUI_PALETTE256_GREY7 = 233,
  FTXUI_PALETTE256_GREY70 = 249,
  FTXUI_PALETTE256_GREY74 = 250,
  FTXUI_PALETTE256_GREY78 = 251,
  FTXUI_PALETTE256_GREY82 = 252,
  FTXUI_PALETTE256_GREY84 = 188,
  FTXUI_PALETTE256_GREY85 = 253,
  FTXUI_PALETTE256_GREY89 = 254,
  FTXUI_PALETTE256_GREY93 = 255,
  FTXUI_PALETTE256_HONEYDEW2 = 194,
  FTXUI_PALETTE256_HOTPINK = 205,
  FTXUI_PALETTE256_HOTPINK2 = 169,
  FTXUI_PALETTE256_HOTPINK3 = 132,
  FTXUI_PALETTE256_HOTPINK3BIS = 168,
  FTXUI_PALETTE256_HOTPINKBIS = 206,
  FTXUI_PALETTE256_INDIANRED = 131,
  FTXUI_PALETTE256_INDIANRED1 = 203,
  FTXUI_PALETTE256_INDIANRED1BIS = 204,
  FTXUI_PALETTE256_INDIANREDBIS = 167,
  FTXUI_PALETTE256_KHAKI1 = 228,
  FTXUI_PALETTE256_KHAKI3 = 185,
  FTXUI_PALETTE256_LIGHTCORAL = 210,
  FTXUI_PALETTE256_LIGHTCYAN1BIS = 195,
  FTXUI_PALETTE256_LIGHTCYAN3 = 152,
  FTXUI_PALETTE256_LIGHTGOLDENROD1 = 227,
  FTXUI_PALETTE256_LIGHTGOLDENROD2 = 186,
  FTXUI_PALETTE256_LIGHTGOLDENROD2BIS = 221,
  FTXUI_PALETTE256_LIGHTGOLDENROD2TER = 222,
  FTXUI_PALETTE256_LIGHTGOLDENROD3 = 179,
  FTXUI_PALETTE256_LIGHTGREEN = 119,
  FTXUI_PALETTE256_LIGHTGREENBIS = 120,
  FTXUI_PALETTE256_LIGHTPINK1 = 217,
  FTXUI_PALETTE256_LIGHTPINK3 = 174,
  FTXUI_PALETTE256_LIGHTPINK4 = 95,
  FTXUI_PALETTE256_LIGHTSALMON1 = 216,
  FTXUI_PALETTE256_LIGHTSALMON3 = 137,
  FTXUI_PALETTE256_LIGHTSALMON3BIS = 173,
  FTXUI_PALETTE256_LIGHTSEAGREEN = 37,
  FTXUI_PALETTE256_LIGHTSKYBLUE1 = 153,
  FTXUI_PALETTE256_LIGHTSKYBLUE3 = 109,
  FTXUI_PALETTE256_LIGHTSKYBLUE3BIS = 110,
  FTXUI_PALETTE256_LIGHTSLATEBLUE = 105,
  FTXUI_PALETTE256_LIGHTSLATEGREY = 103,
  FTXUI_PALETTE256_LIGHTSTEELBLUE = 147,
  FTXUI_PALETTE256_LIGHTSTEELBLUE1 = 189,
  FTXUI_PALETTE256_LIGHTSTEELBLUE3 = 146,
  FTXUI_PALETTE256_LIGHTYELLOW3 = 187,
  FTXUI_PALETTE256_MAGENTA1 = 201,
  FTXUI_PALETTE256_MAGENTA2 = 165,
  FTXUI_PALETTE256_MAGENTA2BIS = 200,
  FTXUI_PALETTE256_MAGENTA3 = 127,
  FTXUI_PALETTE256_MAGENTA3BIS = 163,
  FTXUI_PALETTE256_MAGENTA3TER = 164,
  FTXUI_PALETTE256_MEDIUMORCHID = 134,
  FTXUI_PALETTE256_MEDIUMORCHID1 = 171,
  FTXUI_PALETTE256_MEDIUMORCHID1BIS = 207,
  FTXUI_PALETTE256_MEDIUMORCHID3 = 133,
  FTXUI_PALETTE256_MEDIUMPURPLE = 104,
  FTXUI_PALETTE256_MEDIUMPURPLE1 = 141,
  FTXUI_PALETTE256_MEDIUMPURPLE2 = 135,
  FTXUI_PALETTE256_MEDIUMPURPLE2BIS = 140,
  FTXUI_PALETTE256_MEDIUMPURPLE3 = 97,
  FTXUI_PALETTE256_MEDIUMPURPLE3BIS = 98,
  FTXUI_PALETTE256_MEDIUMPURPLE4 = 60,
  FTXUI_PALETTE256_MEDIUMSPRINGGREEN = 49,
  FTXUI_PALETTE256_MEDIUMTURQUOISE = 80,
  FTXUI_PALETTE256_MEDIUMVIOLETRED = 126,
  FTXUI_PALETTE256_MISTYROSE1 = 224,
  FTXUI_PALETTE256_MISTYROSE3 = 181,
  FTXUI_PALETTE256_NAVAJOWHITE1 = 223,
  FTXUI_PALETTE256_NAVAJOWHITE3 = 144,
  FTXUI_PALETTE256_NAVYBLUE = 17,
  FTXUI_PALETTE256_ORANGE1 = 214,
  FTXUI_PALETTE256_ORANGE3 = 172,
  FTXUI_PALETTE256_ORANGE4 = 58,
  FTXUI_PALETTE256_ORANGE4BIS = 94,
  FTXUI_PALETTE256_ORANGERED1 = 202,
  FTXUI_PALETTE256_ORCHID = 170,
  FTXUI_PALETTE256_ORCHID1 = 213,
  FTXUI_PALETTE256_ORCHID2 = 212,
  FTXUI_PALETTE256_PALEGREEN1 = 121,
  FTXUI_PALETTE256_PALEGREEN1BIS = 156,
  FTXUI_PALETTE256_PALEGREEN3 = 114,
  FTXUI_PALETTE256_PALEGREEN3BIS = 77,
  FTXUI_PALETTE256_PALETURQUOISE1 = 159,
  FTXUI_PALETTE256_PALETURQUOISE4 = 66,
  FTXUI_PALETTE256_PALEVIOLETRED1 = 211,
  FTXUI_PALETTE256_PINK1 = 218,
  FTXUI_PALETTE256_PINK3 = 175,
  FTXUI_PALETTE256_PLUM1 = 219,
  FTXUI_PALETTE256_PLUM2 = 183,
  FTXUI_PALETTE256_PLUM3 = 176,
  FTXUI_PALETTE256_PLUM4 = 96,
  FTXUI_PALETTE256_PURPLE = 129,
  FTXUI_PALETTE256_PURPLE3 = 56,
  FTXUI_PALETTE256_PURPLE4 = 54,
  FTXUI_PALETTE256_PURPLE4BIS = 55,
  FTXUI_PALETTE256_PURPLEBIS = 93,
  FTXUI_PALETTE256_RED1 = 196,
  FTXUI_PALETTE256_RED3 = 124,
  FTXUI_PALETTE256_RED3BIS = 160,
  FTXUI_PALETTE256_ROSYBROWN = 138,
  FTXUI_PALETTE256_ROYALBLUE1 = 63,
  FTXUI_PALETTE256_SALMON1 = 209,
  FTXUI_PALETTE256_SANDYBROWN = 215,
  FTXUI_PALETTE256_SEAGREEN1 = 84,
  FTXUI_PALETTE256_SEAGREEN1BIS = 85,
  FTXUI_PALETTE256_SEAGREEN2 = 83,
  FTXUI_PALETTE256_SEAGREEN3 = 78,
  FTXUI_PALETTE256_SKYBLUE1 = 117,
  FTXUI_PALETTE256_SKYBLUE2 = 111,
  FTXUI_PALETTE256_SKYBLUE3 = 74,
  FTXUI_PALETTE256_SLATEBLUE1 = 99,
  FTXUI_PALETTE256_SLATEBLUE3 = 61,
  FTXUI_PALETTE256_SLATEBLUE3BIS = 62,
  FTXUI_PALETTE256_SPRINGGREEN1 = 48,
  FTXUI_PALETTE256_SPRINGGREEN2 = 42,
  FTXUI_PALETTE256_SPRINGGREEN2BIS = 47,
  FTXUI_PALETTE256_SPRINGGREEN3 = 35,
  FTXUI_PALETTE256_SPRINGGREEN3BIS = 41,
  FTXUI_PALETTE256_SPRINGGREEN4 = 29,
  FTXUI_PALETTE256_STEELBLUE = 67,
  FTXUI_PALETTE256_STEELBLUE1 = 75,
  FTXUI_PALETTE256_STEELBLUE1BIS = 81,
  FTXUI_PALETTE256_STEELBLUE3 = 68,
  FTXUI_PALETTE256_TAN = 180,
  FTXUI_PALETTE256_THISTLE1 = 225,
  FTXUI_PALETTE256_THISTLE3 = 182,
  FTXUI_PALETTE256_TURQUOISE2 = 45,
  FTXUI_PALETTE256_TURQUOISE4 = 30,
  FTXUI_PALETTE256_VIOLET = 177,
  FTXUI_PALETTE256_WHEAT1 = 229,
  FTXUI_PALETTE256_WHEAT4 = 101,
  FTXUI_PALETTE256_YELLOW1 = 226,
  FTXUI_PALETTE256_YELLOW2 = 190,
  FTXUI_PALETTE256_YELLOW3 = 148,
  FTXUI_PALETTE256_YELLOW3BIS = 184,
  FTXUI_PALETTE256_YELLOW4 = 100,
  FTXUI_PALETTE256_YELLOW4BIS = 106
}
extern fn ColorHandle create_default() @cname("ftxui_color_default");
extern fn ColorHandle from_rgb(char r, char g, char b) @cname("ftxui_color_rgb");
extern fn ColorHandle from_rgba(char r, char g, char b, char a) @cname("ftxui_color_rgba");
extern fn ColorHandle from_hsv(char h, char s, char v) @cname("ftxui_color_hsv");
extern fn ColorHandle from_hsva(char h, char s, char v, char a) @cname("ftxui_color_hsva");
extern fn ColorHandle from_palette1(Palette1 index) @cname("ftxui_color_palette1");
extern fn ColorHandle from_palette16(Palette16 index) @cname("ftxui_color_palette16");
extern fn ColorHandle from_palette256(Palette256 index) @cname("ftxui_color_palette256");
extern fn ColorHandle from_raw_palette256(CInt index) @cname("ftxui_color_palette256_raw");
extern fn ColorHandle interpolate(float t, ColorHandle a, ColorHandle b) @cname("ftxui_color_interpolate");
extern fn ColorHandle blend(ColorHandle lhs, ColorHandle rhs) @cname("ftxui_color_blend");
extern fn bool ColorHandle.is_opaque(self) @cname("ftxui_color_is_opaque");
extern fn bool ColorHandle.equals(self, ColorHandle rhs) @operator(==) @cname("ftxui_color_equals");
extern fn bool ColorHandle.not_equals(self, ColorHandle rhs) @cname("ftxui_color_not_equals");
extern fn ZString ColorHandle.print(self, bool is_background_color) @cname("ftxui_color_print");
extern fn void ColorHandle.free(self) @cname("ftxui_color_destroy");

module ftxui::screen::color_info;
import ftxui::screen::color;
struct ColorInfo {
  CInt index_256;
  char index_16;
  CChar* name;
  char red;
  char green;
  char blue;
  char hue;
  char saturation;
  char value;
}
extern fn ColorInfo* sorted_2d(CInt* num_rows, CInt* max_cols) @cname("ftxui_color_info_sorted_2d");
extern fn void ColorInfo.info_free(&self) @cname("ftxui_color_info_free");
extern fn ColorInfo from_palette_256(Palette256 index) @cname("ftxui_color_info_get_256");
extern fn ColorInfo from_palette_16(Palette16 index) @cname("ftxui_color_info_get_16");

module ftxui::dom::linear_gradient;
extern fn LinearGradientHandle create() @cname("ftxui_linear_gradient_create");
extern fn void LinearGradientHandle.free(self) @cname("ftxui_linear_gradient_destroy");
extern fn void LinearGradientHandle.angle(self, float angle) @cname("ftxui_linear_gradient_angle");
extern fn void LinearGradientHandle.stop(self, ColorHandle color) @cname("ftxui_linear_gradient_stop");
extern fn void LinearGradientHandle.stop_at(self, ColorHandle color, float position) @cname("ftxui_linear_gradient_stop_at");

module ftxui::dom::elements;
extern fn ElementHandle ElementHandle.color_linear_gradient(self, LinearGradientHandle gradient) @cname("ftxui_element_color_linear_gradient");
extern fn ElementHandle ElementHandle.bgcolor_linear_gradient(self, LinearGradientHandle gradient) @cname("ftxui_element_bgcolor_linear_gradient");
extern fn ElementHandle text(ZString text) @cname("ftxui_element_text");
extern fn ElementHandle vtext(ZString text) @cname("ftxui_element_vtext");
extern fn ElementHandle paragraph(ZString text) @cname("ftxui_element_paragraph");
extern fn ElementHandle paragraph_align_left(ZString text) @cname("ftxui_element_paragraph_align_left");
extern fn ElementHandle paragraph_align_right(ZString text) @cname("ftxui_element_paragraph_align_right");
extern fn ElementHandle paragraph_align_center(ZString text) @cname("ftxui_element_paragraph_align_center");
extern fn ElementHandle paragraph_align_justify(ZString text) @cname("ftxui_element_paragraph_align_justify");
extern fn ElementHandle empty() @cname("ftxui_element_empty");
extern fn ElementHandle filler() @cname("ftxui_element_filler");
extern fn ElementHandle gauge(double value) @cname("ftxui_element_gauge");
extern fn ElementHandle gauge_left(double value) @cname("ftxui_element_gauge_left");
extern fn ElementHandle gauge_right(double value) @cname("ftxui_element_gauge_right");
extern fn ElementHandle gauge_up(double value) @cname("ftxui_element_gauge_up");
extern fn ElementHandle gauge_down(double value) @cname("ftxui_element_gauge_down");
constdef Direction : CInt {
  FTXUI_DIRECTION_UP = 0,
  FTXUI_DIRECTION_DOWN = 1,
  FTXUI_DIRECTION_LEFT = 2,
  FTXUI_DIRECTION_RIGHT = 3
}
extern fn ElementHandle gauge_direction(double value, Direction direction) @cname("ftxui_element_gauge_direction");
extern fn ElementHandle spinner(CInt charset_index, CInt image_index) @cname("ftxui_element_spinner");
alias GraphCallback = fn void(CInt width, CInt height, CInt* output, void* userdata);
extern fn ElementHandle graph(GraphCallback callback, void* userdata, Destructor destructor) @cname("ftxui_element_graph");
extern fn ElementHandle window(ElementHandle title, ElementHandle element) @cname("ftxui_element_window");
extern fn void ElementHandle.free(self) @cname("ftxui_element_destroy");
extern fn ElementHandle separator() @cname("ftxui_element_separator");
extern fn ElementHandle separator_light() @cname("ftxui_element_separator_light");
extern fn ElementHandle separator_dashed() @cname("ftxui_element_separator_dashed");
extern fn ElementHandle separator_heavy() @cname("ftxui_element_separator_heavy");
extern fn ElementHandle separator_double() @cname("ftxui_element_separator_double");
extern fn ElementHandle separator_empty() @cname("ftxui_element_separator_empty");
extern fn ElementHandle separator_styled(BorderStyle style) @cname("ftxui_element_separator_styled");
extern fn ElementHandle separator_character(CChar* character) @cname("ftxui_element_separator_character");
extern fn ElementHandle separator_hselector(float left, float right, ColorHandle unselected_color, ColorHandle selected_color) @cname("ftxui_element_separator_hselector");
extern fn ElementHandle separator_vselector(float up, float down, ColorHandle unselected_color, ColorHandle selected_color) @cname("ftxui_element_separator_vselector");
extern fn ElementHandle _hbox(ElementHandle* elements, CInt count) @cname("ftxui_element_hbox");
fn ElementHandle hbox(ElementHandle[] elements) {
  return _hbox(elements.ptr, elements.len);
}
extern fn ElementHandle _vbox(ElementHandle* elements, CInt count) @cname("ftxui_element_vbox");
fn ElementHandle vbox(ElementHandle[] elements) {
  return _vbox(elements.ptr, elements.len);
}
extern fn ElementHandle _dbox(ElementHandle* elements, CInt count) @cname("ftxui_element_dbox");
fn ElementHandle dbox(ElementHandle[] elements) {
  return _dbox(elements.ptr, elements.len);
}
extern fn ElementHandle _hflow(ElementHandle* elements, CInt count) @cname("ftxui_element_hflow");
fn ElementHandle hflow(ElementHandle[] elements) {
  return _hflow(elements.ptr, elements.len);
}
extern fn ElementHandle _vflow(ElementHandle* elements, CInt count) @cname("ftxui_element_vflow");
fn ElementHandle vflow(ElementHandle[] elements) {
  return _vflow(elements.ptr, elements.len);
}
extern fn ElementHandle _gridbox(ElementHandle* cells, CInt total_cells, CInt* row_lengths, CInt row_count) @cname("ftxui_element_gridbox");
fn ElementHandle gridbox(ElementHandle[] cells, CInt[] row_lengths) {
  return _gridbox(cells.ptr, cells.len, row_lengths.ptr, row_lengths.len);
}
constdef FlexboxDirection : CInt {
  FTXUI_FLEXBOX_DIRECTION_ROW = 0,
  FTXUI_FLEXBOX_DIRECTION_ROW_INVERSED = 1,
  FTXUI_FLEXBOX_DIRECTION_COLUMN = 2,
  FTXUI_FLEXBOX_DIRECTION_COLUMN_INVERSED = 3
}
constdef FlexboxWrap : CInt {
  FTXUI_FLEXBOX_WRAP_NO_WRAP = 0,
  FTXUI_FLEXBOX_WRAP_WRAP = 1,
  FTXUI_FLEXBOX_WRAP_WRAP_INVERSED = 2
}
constdef FlexboxJustify : CInt {
  FTXUI_FLEXBOX_JUSTIFY_FLEX_START = 0,
  FTXUI_FLEXBOX_JUSTIFY_FLEX_END = 1,
  FTXUI_FLEXBOX_JUSTIFY_CENTER = 2,
  FTXUI_FLEXBOX_JUSTIFY_STRETCH = 3,
  FTXUI_FLEXBOX_JUSTIFY_SPACE_BETWEEN = 4,
  FTXUI_FLEXBOX_JUSTIFY_SPACE_AROUND = 5,
  FTXUI_FLEXBOX_JUSTIFY_SPACE_EVENLY = 6
}
constdef FlexboxAlignItems : CInt {
  FTXUI_FLEXBOX_ALIGN_ITEMS_FLEX_START = 0,
  FTXUI_FLEXBOX_ALIGN_ITEMS_FLEX_END = 1,
  FTXUI_FLEXBOX_ALIGN_ITEMS_CENTER = 2,
  FTXUI_FLEXBOX_ALIGN_ITEMS_STRETCH = 3
}
constdef FlexboxAlignContent : CInt {
  FTXUI_FLEXBOX_ALIGN_CONTENT_FLEX_START = 0,
  FTXUI_FLEXBOX_ALIGN_CONTENT_FLEX_END = 1,
  FTXUI_FLEXBOX_ALIGN_CONTENT_CENTER = 2,
  FTXUI_FLEXBOX_ALIGN_CONTENT_STRETCH = 3,
  FTXUI_FLEXBOX_ALIGN_CONTENT_SPACE_BETWEEN = 4,
  FTXUI_FLEXBOX_ALIGN_CONTENT_SPACE_AROUND = 5,
  FTXUI_FLEXBOX_ALIGN_CONTENT_SPACE_EVENLY = 6
}
struct FlexboxConfig {
  FlexboxDirection direction;
  FlexboxWrap wrap;
  FlexboxJustify justify_content;
  FlexboxAlignItems align_items;
  FlexboxAlignContent align_content;
  CInt gap_x;
  CInt gap_y;
}
extern fn ElementHandle _flexbox(ElementHandle* elements, CInt count, FlexboxConfig config) @cname("ftxui_element_flexbox");
fn ElementHandle flexbox(ElementHandle[] elements, FlexboxConfig config) {
  return _flexbox(elements.ptr, elements.len, config);
}
extern fn ElementHandle ElementHandle.border(self) @cname("ftxui_element_border");
extern fn ElementHandle ElementHandle.border_light(self) @cname("ftxui_element_border_light");
extern fn ElementHandle ElementHandle.border_dashed(self) @cname("ftxui_element_border_dashed");
extern fn ElementHandle ElementHandle.border_heavy(self) @cname("ftxui_element_border_heavy");
extern fn ElementHandle ElementHandle.border_double(self) @cname("ftxui_element_border_double");
extern fn ElementHandle ElementHandle.border_rounded(self) @cname("ftxui_element_border_rounded");
extern fn ElementHandle ElementHandle.border_empty(self) @cname("ftxui_element_border_empty");
extern fn ElementHandle ElementHandle.border_styled(self, BorderStyle style) @cname("ftxui_element_border_styled");
extern fn ElementHandle ElementHandle.border_styled_color(self, BorderStyle style, ColorHandle color) @cname("ftxui_element_border_styled_color");
extern fn ElementHandle ElementHandle.border_colored(self, ColorHandle color) @cname("ftxui_element_border_colored");
extern fn ElementHandle ElementHandle.bold(self) @cname("ftxui_element_bold");
extern fn ElementHandle ElementHandle.dim(self) @cname("ftxui_element_dim");
extern fn ElementHandle ElementHandle.italic(self) @cname("ftxui_element_italic");
extern fn ElementHandle ElementHandle.inverted(self) @cname("ftxui_element_inverted");
extern fn ElementHandle ElementHandle.underlined(self) @cname("ftxui_element_underlined");
extern fn ElementHandle ElementHandle.underlined_double(self) @cname("ftxui_element_underlined_double");
extern fn ElementHandle ElementHandle.blink(self) @cname("ftxui_element_blink");
extern fn ElementHandle ElementHandle.strikethrough(self) @cname("ftxui_element_strikethrough");
extern fn ElementHandle ElementHandle.color(self, ColorHandle color) @cname("ftxui_element_color");
extern fn ElementHandle ElementHandle.bgcolor(self, ColorHandle color) @cname("ftxui_element_bgcolor");
extern fn ElementHandle ElementHandle.automerge(self) @cname("ftxui_element_automerge");
extern fn ElementHandle hyperlink(ZString link, ElementHandle element) @cname("ftxui_element_hyperlink");
fn ElementHandle ElementHandle.hyperlink(self, ZString link) {
  return hyperlink(link, self);
}
extern fn ElementHandle ElementHandle.clear_under(self) @cname("ftxui_element_clear_under");
extern fn ElementHandle ElementHandle.nothing(self) @cname("ftxui_element_nothing");
struct Cell {
  bool blink;
  bool bold;
  bool dim;
  bool italic;
  bool inverted;
  bool underlined;
  bool underlined_double;
  bool strikethrough;
  bool automerge;
  ColorHandle foreground_color;
  ColorHandle background_color;
}
alias CellStyleCallback = fn void(Cell* cell, void* userdata);
extern fn ElementHandle ElementHandle.selection_style_reset(self) @cname("ftxui_element_selection_style_reset");
extern fn ElementHandle ElementHandle.selection_color(self, ColorHandle color) @cname("ftxui_element_selection_color");
extern fn ElementHandle ElementHandle.selection_background_color(self, ColorHandle color) @cname("ftxui_element_selection_background_color");
extern fn ElementHandle ElementHandle.selection_foreground_color(self, ColorHandle color) @cname("ftxui_element_selection_foreground_color");
extern fn ElementHandle ElementHandle.selection_style(self, CellStyleCallback callback, void* userdata, Destructor destructor) @cname("ftxui_element_selection_style");
constdef WidthOrHeight : CInt {
  FTXUI_WIDTH_OR_HEIGHT_WIDTH = 0,
  FTXUI_WIDTH_OR_HEIGHT_HEIGHT = 1
}
constdef Constraint : CInt {
  FTXUI_CONSTRAINT_LESS_THAN = 0,
  FTXUI_CONSTRAINT_GREATER_THAN = 1,
  FTXUI_CONSTRAINT_EQUAL = 2
}
extern fn ElementHandle ElementHandle.flex(self) @cname("ftxui_element_flex");
extern fn ElementHandle ElementHandle.flex_grow(self) @cname("ftxui_element_flex_grow");
extern fn ElementHandle ElementHandle.flex_shrink(self) @cname("ftxui_element_flex_shrink");
extern fn ElementHandle ElementHandle.xflex(self) @cname("ftxui_element_xflex");
extern fn ElementHandle ElementHandle.xflex_grow(self) @cname("ftxui_element_xflex_grow");
extern fn ElementHandle ElementHandle.xflex_shrink(self) @cname("ftxui_element_xflex_shrink");
extern fn ElementHandle ElementHandle.yflex(self) @cname("ftxui_element_yflex");
extern fn ElementHandle ElementHandle.yflex_grow(self) @cname("ftxui_element_yflex_grow");
extern fn ElementHandle ElementHandle.yflex_shrink(self) @cname("ftxui_element_yflex_shrink");
extern fn ElementHandle ElementHandle.notflex(self) @cname("ftxui_element_notflex");
extern fn ElementHandle ElementHandle.set_size(self, WidthOrHeight width_or_height, Constraint constraint_type, CInt value) @cname("ftxui_element_set_size");
extern fn ElementHandle ElementHandle.frame(self) @cname("ftxui_element_frame");
extern fn ElementHandle ElementHandle.xframe(self) @cname("ftxui_element_xframe");
extern fn ElementHandle ElementHandle.yframe(self) @cname("ftxui_element_yframe");
extern fn ElementHandle ElementHandle.vscroll_indicator(self) @cname("ftxui_element_vscroll_indicator");
extern fn ElementHandle ElementHandle.hscroll_indicator(self) @cname("ftxui_element_hscroll_indicator");
extern fn ElementHandle ElementHandle.focus(self) @cname("ftxui_element_focus");
extern fn ElementHandle ElementHandle.focus_cursor_block(self) @cname("ftxui_element_focus_cursor_block");
extern fn ElementHandle ElementHandle.focus_cursor_block_blinking(self) @cname("ftxui_element_focus_cursor_block_blinking");
extern fn ElementHandle ElementHandle.focus_cursor_bar(self) @cname("ftxui_element_focus_cursor_bar");
extern fn ElementHandle ElementHandle.focus_cursor_bar_blinking(self) @cname("ftxui_element_focus_cursor_bar_blinking");
extern fn ElementHandle ElementHandle.focus_cursor_underline(self) @cname("ftxui_element_focus_cursor_underline");
extern fn ElementHandle ElementHandle.focus_cursor_underline_blinking(self) @cname("ftxui_element_focus_cursor_underline_blinking");
extern fn ElementHandle ElementHandle.focus_position(self, CInt x, CInt y) @cname("ftxui_element_focus_position");
extern fn ElementHandle ElementHandle.focus_position_relative(self, float x, float y) @cname("ftxui_element_focus_position_relative");

extern fn BoxHandle create_box() @cname("ftxui_box_create");
extern fn void BoxHandle.free(self) @cname("ftxui_box_destroy");
extern fn CInt BoxHandle.x_min(self) @cname("ftxui_box_x_min");
extern fn CInt BoxHandle.x_max(self) @cname("ftxui_box_x_max");
extern fn CInt BoxHandle.y_min(self) @cname("ftxui_box_y_min");
extern fn CInt BoxHandle.y_max(self) @cname("ftxui_box_y_max");
extern fn CInt BoxHandle.width(self) @cname("ftxui_box_width");
extern fn CInt BoxHandle.height(self) @cname("ftxui_box_height");

extern fn ElementHandle ElementHandle.reflect(self, BoxHandle box) @cname("ftxui_element_reflect");
extern fn ElementHandle ElementHandle.hcenter(self) @cname("ftxui_element_hcenter");
extern fn ElementHandle ElementHandle.vcenter(self) @cname("ftxui_element_vcenter");
extern fn ElementHandle ElementHandle.center(self) @cname("ftxui_element_center");
extern fn ElementHandle ElementHandle.align_right(self) @cname("ftxui_element_align_right");

extern fn CanvasHandle create_canvas(CInt width, CInt height) @cname("ftxui_canvas_create");
extern fn void CanvasHandle.free(self) @cname("ftxui_canvas_destroy");
extern fn CInt CanvasHandle.width(self) @cname("ftxui_canvas_width");
extern fn CInt CanvasHandle.height(self) @cname("ftxui_canvas_height");
extern fn void CanvasHandle.draw_text(self, CInt x, CInt y, ZString text) @cname("ftxui_canvas_draw_text");
extern fn void CanvasHandle.draw_text_color(self, CInt x, CInt y, ZString text, ColorHandle color) @cname("ftxui_canvas_draw_text_color");
extern fn void CanvasHandle.draw_text_stylizer(self, CInt x, CInt y, CChar* text, CellStyleCallback callback, void* userdata) @cname("ftxui_canvas_draw_text_stylizer");
extern fn void CanvasHandle.draw_point_on(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_point_on");
extern fn void CanvasHandle.draw_point_off(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_point_off");
extern fn void CanvasHandle.draw_point_toggle(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_point_toggle");
extern fn void CanvasHandle.draw_point(
  self,
  CInt x,
  CInt y,
  bool value)
@cname("ftxui_canvas_draw_point");
extern fn void CanvasHandle.draw_point_color(
  self,
  CInt x,
  CInt y,
  bool value,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_color");
extern fn void CanvasHandle.draw_point_stylizer(
  self,
  CInt x,
  CInt y,
  bool value,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_stylizer");
extern fn void CanvasHandle.draw_point_line(
  self,
  CInt x1,
  CInt y1,
  CInt x2,
  CInt y2,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_line");
extern fn void CanvasHandle.draw_point_line_stylizer(
  self,
  CInt x1,
  CInt y1,
  CInt x2,
  CInt y2,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_line_stylizer");
extern fn void CanvasHandle.draw_point_circle(
  self,
  CInt x,
  CInt y,
  CInt radius)
@cname("ftxui_canvas_draw_point_circle");
extern fn void CanvasHandle.draw_point_circle_color(
  self,
  CInt x,
  CInt y,
  CInt radius,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_circle_color");
extern fn void CanvasHandle.draw_point_circle_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_circle_stylizer");
extern fn void CanvasHandle.draw_point_circle_filled(
  self,
  CInt x,
  CInt y,
  CInt radius)
@cname("ftxui_canvas_draw_point_circle_filled");
extern fn void CanvasHandle.draw_point_circle_filled_color(
  self,
  CInt x,
  CInt y,
  CInt radius,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_circle_filled_color");
extern fn void CanvasHandle.draw_point_circle_filled_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_circle_filled_stylizer");
extern fn void CanvasHandle.draw_point_ellipse(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y)
@cname("ftxui_canvas_draw_point_ellipse");
extern fn void CanvasHandle.draw_point_ellipse_color(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_ellipse_color");
extern fn void CanvasHandle.draw_point_ellipse_stylizer(
  self,
  CInt x,
  CInt y,
  CInt rx,
  CInt ry,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_ellipse_stylizer");
extern fn void CanvasHandle.draw_point_ellipse_filled(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y)
@cname("ftxui_canvas_draw_point_ellipse_filled");
extern fn void CanvasHandle.draw_point_ellipse_filled_color(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  ColorHandle color)
@cname("ftxui_canvas_draw_point_ellipse_filled_color");
extern fn void CanvasHandle.draw_point_ellipse_filled_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_point_ellipse_filled_stylizer");
extern fn void CanvasHandle.draw_block_on(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_block_on");
extern fn void CanvasHandle.draw_block_off(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_block_off");
extern fn void CanvasHandle.draw_block_toggle(
  self,
  CInt x,
  CInt y)
@cname("ftxui_canvas_draw_block_toggle");
extern fn void CanvasHandle.draw_block(
  self,
  CInt x,
  CInt y,
  bool value)
@cname("ftxui_canvas_draw_block");
extern fn void CanvasHandle.draw_block_color(
  self,
  CInt x,
  CInt y,
  bool value,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_color");
extern fn void CanvasHandle.draw_block_stylizer(
  self,
  CInt x,
  CInt y,
  bool value,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_stylizer");
extern fn void CanvasHandle.draw_block_line(
  self,
  CInt x1,
  CInt y1,
  CInt x2,
  CInt y2,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_line");
extern fn void CanvasHandle.draw_block_line_stylizer(
  self,
  CInt x1,
  CInt y1,
  CInt x2,
  CInt y2,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_line_stylizer");
extern fn void CanvasHandle.draw_block_circle(
  self,
  CInt x,
  CInt y,
  CInt radius)
@cname("ftxui_canvas_draw_block_circle");
extern fn void CanvasHandle.draw_block_circle_color(
  self,
  CInt x,
  CInt y,
  CInt radius,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_circle_color");
extern fn void CanvasHandle.draw_block_circle_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_circle_stylizer");
extern fn void CanvasHandle.draw_block_circle_filled(
  self,
  CInt x,
  CInt y,
  CInt radius)
@cname("ftxui_canvas_draw_block_circle_filled");
extern fn void CanvasHandle.draw_block_circle_filled_color(
  self,
  CInt x,
  CInt y,
  CInt radius,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_circle_filled_color");
extern fn void CanvasHandle.draw_block_circle_filled_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_circle_filled_stylizer");
extern fn void CanvasHandle.draw_block_ellipse(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y)
@cname("ftxui_canvas_draw_block_ellipse");
extern fn void CanvasHandle.draw_block_ellipse_color(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_ellipse_color");
extern fn void CanvasHandle.draw_block_ellipse_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_ellipse_stylizer");
extern fn void CanvasHandle.draw_block_ellipse_filled(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y)
@cname("ftxui_canvas_draw_block_ellipse_filled");
extern fn void CanvasHandle.draw_block_ellipse_filled_color(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  ColorHandle color)
@cname("ftxui_canvas_draw_block_ellipse_filled_color");
extern fn void CanvasHandle.draw_block_ellipse_filled_stylizer(
  self,
  CInt x,
  CInt y,
  CInt radius_x,
  CInt radius_y,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_draw_block_ellipse_filled_stylizer");
extern fn void CanvasHandle.style(
  self,
  CInt x,
  CInt y,
  CellStyleCallback callback,
  void* userdata)
@cname("ftxui_canvas_style");
extern fn ElementHandle CanvasHandle.as_element_ref(self) @cname("ftxui_element_canvas_ref");

alias DecoratorCallback = fn ElementHandle(
  ElementHandle element,
  void* userdata);

extern fn TableHandle _create_table(
  CChar** cells,
  CInt rows,
  CInt cols)
@cname("ftxui_table_create");
fn TableHandle create_table(ZString[] cells, CInt rows, CInt columns) {
  return _create_table((CChar**)cells.ptr, rows, columns);
}
extern fn void TableHandle.free(self)
@cname("ftxui_table_destroy");
extern fn ElementHandle TableHandle.render(self)
@cname("ftxui_table_render");
extern fn TableSelectionHandle TableHandle.select_all(
  self)
@cname("ftxui_table_select_all");
extern fn TableSelectionHandle TableHandle.select_row(
  self,
  CInt row)
@cname("ftxui_table_select_row");
extern fn TableSelectionHandle TableHandle.select_rows(
  self,
  CInt from,
  CInt to)
@cname("ftxui_table_select_rows");
extern fn TableSelectionHandle TableHandle.select_column(
  self,
  CInt col)
@cname("ftxui_table_select_column");
extern fn TableSelectionHandle TableHandle.select_cell(
  self,
  CInt col,
  CInt row)
@cname("ftxui_table_select_cell");
extern fn TableSelectionHandle TableHandle.select_columns(
  self,
  CInt from,
  CInt to)
@cname("ftxui_table_select_columns");
extern fn TableSelectionHandle TableHandle.select_rectangle(
  self,
  CInt min_columns,
  CInt max_columns,
  CInt min_rows,
  CInt max_rows)
@cname("ftxui_table_select_rectangle");

extern fn void TableSelectionHandle.free(
  self)
@cname("ftxui_table_selection_destroy");
extern fn void TableSelectionHandle.border(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_border");
extern fn void TableSelectionHandle.border_color(
  self,
  BorderStyle style,
  ColorHandle color)
@cname("ftxui_table_selection_border_color");
extern fn void TableSelectionHandle.border_left(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_border_left");
extern fn void TableSelectionHandle.border_right(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_border_right");
extern fn void TableSelectionHandle.border_top(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_border_top");
extern fn void TableSelectionHandle.border_bottom(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_border_bottom");
extern fn void TableSelectionHandle.separator(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_separator");
extern fn void TableSelectionHandle.separator_vertical(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_separator_vertical");
extern fn void TableSelectionHandle.separator_horizontal(
  self,
  BorderStyle style)
@cname("ftxui_table_selection_separator_horizontal");
extern fn void TableSelectionHandle.decorate(
  self,
  DecoratorCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate");
extern fn void TableSelectionHandle.decorate_alternate_row(
  self,
  DecoratorCallback callback,
  void* userdata,
  CInt modulo,
  CInt shift,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_alternate_row");
extern fn void TableSelectionHandle.decorate_alternate_column(
  self,
  DecoratorCallback callback,
  void* userdata,
  CInt modulo,
  CInt shift,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_alternate_column");
extern fn void TableSelectionHandle.decorate_border(
  self,
  DecoratorCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_border");
extern fn void TableSelectionHandle.decorate_border_left(
  self,
  DecoratorCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_border_left");
extern fn void TableSelectionHandle.decorate_border_right(
  self,
  DecoratorCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_border_right");
extern fn void TableSelectionHandle.decorate_border_top(
  self,
  DecoratorCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_border_top");
extern fn void TableSelectionHandle.decorate_border_bottom(
  self,
  DecoratorCallback cb,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_border_bottom");
extern fn void TableSelectionHandle.decorate_separator(
  self,
  DecoratorCallback cb,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_separator");
extern fn void TableSelectionHandle.decorate_separator_vertical(
  self,
  DecoratorCallback cb,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_separator_vertical");
extern fn void TableSelectionHandle.decorate_separator_horizontal(
  self,
  DecoratorCallback cb,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_separator_horizontal");
extern fn void TableSelectionHandle.decorate_cells(
  self,
  DecoratorCallback cb,
  void* userdata,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_cells");
extern fn void TableSelectionHandle.decorate_cells_alternate_row(
  self,
  DecoratorCallback cb,
  void* userdata,
  CInt modulo,
  CInt shift,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_cells_alternate_row");
extern fn void TableSelectionHandle.decorate_cells_alternate_column(
  self,
  DecoratorCallback cb,
  void* userdata,
  CInt modulo,
  CInt shift,
  Destructor destructor)
@cname("ftxui_table_selection_decorate_cells_alternate_column");
extern fn void TableSelectionHandle.decorate_bold(
  self)
@cname("ftxui_table_selection_decorate_bold");
extern fn void TableSelectionHandle.decorate_cells_align_right(
  self)
@cname("ftxui_table_selection_decorate_cells_align_right");
extern fn void TableSelectionHandle.decorate_cells_color(
  self,
  ColorHandle color)
@cname("ftxui_table_selection_decorate_cells_color");
extern fn void TableSelectionHandle.decorate_cells_color_alternate_row(
  self,
  ColorHandle color,
  CInt modulo,
  CInt offset)
@cname("ftxui_table_selection_decorate_cells_color_alternate_row");

module ftxui::component;
import ftxui::component::app;
struct AnimatedColorOption {
  bool enabled;
  ColorHandle inactive;
  ColorHandle active;
  CInt duration_ms;
  EasingFunctionType easing_function_type;
}
struct AnimatedColorsOption {
  AnimatedColorOption background;
  AnimatedColorOption foreground;
}
struct EntryState {
  CChar* label;
  bool state;
  bool active;
  bool focused;
  CInt index;
}
alias ButtonTransform = fn ElementHandle(
  EntryState state,
  void* userdata);
struct ButtonOption {
  AnimatedColorsOption animated_colors;
  ButtonTransform transform;
  void* transform_userdata;
  Destructor transform_destructor;
}
extern fn ComponentHandle button(
  ZString label,
  UserdataCallback on_click,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_button");
extern fn ComponentHandle button_with_options(
  ZString label,
  UserdataCallback on_click,
  void* userdata,
  Destructor destructor,
  ButtonOption options)
@cname("ftxui_component_button_with_options");
extern fn ButtonOption button_option_simple()
@cname("ftxui_button_option_simple");
extern fn ButtonOption button_option_ascii()
@cname("ftxui_button_option_ascii");
extern fn ButtonOption button_option_border()
@cname("ftxui_button_option_border");
extern fn ButtonOption button_option_animated(
  ColorHandle background,
  ColorHandle foreground,
  ColorHandle background_active,
  ColorHandle foreground_active)
@cname("ftxui_button_option_animated");
extern fn ComponentHandle checkbox(
  ZString label,
  bool* checked)
@cname("ftxui_component_checkbox");
extern fn ComponentHandle checkbox_with_change(
  ZString label,
  bool* checked,
  Callback on_change,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_checkbox_with_change");
extern fn MutableCppStdStringHandle mutable_cpp_std_string(
  ZString initial)
@cname("ftxui_string_create");
extern fn ZString MutableCppStdStringHandle.get(
  self)
@cname("ftxui_string_get");
extern fn void MutableCppStdStringHandle.set(
  self,
  ZString value)
@cname("ftxui_string_set");
extern fn void MutableCppStdStringHandle.free(
  self)
@cname("ftxui_string_destroy");

extern fn ComponentHandle input(
  MutableCppStdStringHandle content,
  ZString placeholder)
@cname("ftxui_component_input");
extern fn ComponentHandle input_password(
  MutableCppStdStringHandle content,
  ZString placeholder)
@cname("ftxui_component_input_password");

struct InputOptions {
  MutableCppStdStringHandle content;
  ZString placeholder;
  bool* multiline;
  bool* insert;
  CInt* cursor_position;
  Callback on_change;
  void* on_change_userdata;
  Destructor on_change_destructor;
  Callback on_enter;
  void* on_enter_userdata;
  Destructor on_enter_destructor;
}

extern fn ComponentHandle input_with_options(
  InputOptions opts)
@cname("ftxui_component_input_with_options");
extern fn ComponentHandle _toggle(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_toggle");
fn ComponentHandle toggle(ZString[] entries, CInt* selected) {
  return _toggle((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle slider(
  ZString label,
  CInt* value,
  CInt min,
  CInt max,
  CInt increment)
@cname("ftxui_component_slider");
extern fn ComponentHandle slider_int_with_change(
  CInt* value,
  CInt min,
  CInt max,
  CInt increment,
  Callback on_change,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_slider_int_with_change");
extern fn ComponentHandle slider_float_with_change(
  float* value,
  float min,
  float max,
  float increment,
  Callback on_change,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_slider_float_with_change");
import ftxui::dom; // TODO: Move `Direction` to `ftxui::dom::direction`.
extern fn ComponentHandle slider_int_direction(
  CInt* value,
  CInt min,
  CInt max,
  CInt increment,
  Direction direction)
@cname("ftxui_component_slider_int_direction");
extern fn ComponentHandle slider_float(
  ZString label,
  float* value,
  float min,
  float max,
  float increment)
@cname("ftxui_component_slider_float");
extern fn ComponentHandle slider_float_direction(
  float* value,
  float min,
  float max,
  float increment,
  Direction direction,
  ColorHandle color_active,
  ColorHandle color_inactive)
@cname("ftxui_component_slider_float_direction");
extern fn ComponentHandle _radiobox(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_radiobox");
fn ComponentHandle radiobox(ZString[] entries, CInt* selected) {
  return _radiobox((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle _radiobox_with_change(
  CChar** entries,
  CInt count,
  CInt* selected,
  Callback on_change,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_radiobox_with_change");
fn ComponentHandle radiobox_with_change(ZString[] entries, CInt* selected, Callback on_change, void* userdata, Destructor destructor) {
  return _radiobox_with_change((CChar**)entries.ptr, entries.len, selected, on_change, userdata, destructor);
}
extern fn ComponentHandle _menu(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_menu");
fn ComponentHandle menu(ZString[] entries, CInt* selected) {
  return _menu((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle _menu_with_callbacks(
  CChar** entries,
  CInt count,
  CInt* selected,
  Callback on_change,
  void* on_change_userdata,
  Destructor on_change_destructor,
  Callback on_enter,
  void* on_enter_userdata,
  Destructor on_enter_destructor)
@cname("ftxui_component_menu_with_callbacks");
fn ComponentHandle menu_with_callbacks(ZString[] entries, CInt* selected, Callback on_change, void* on_change_userdata, Destructor on_change_destructor, Callback on_enter, void* on_enter_userdata, Destructor on_enter_destructor) {
  return _menu_with_callbacks((CChar**)entries.ptr, entries.len, selected, on_change, on_change_userdata, on_change_destructor, on_enter, on_enter_userdata, on_enter_destructor);
}
extern fn ComponentHandle menu_entry(
  ZString label)
@cname("ftxui_component_menu_entry");
extern fn ComponentHandle menu_entry_animated(
  ZString label,
  AnimatedColorsOption animated_colors)
@cname("ftxui_component_menu_entry_animated");
extern fn ComponentHandle _menu_horizontal(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_menu_horizontal");
fn ComponentHandle menu_horizontal(ZString[] entries, CInt* selected) {
  return _menu_horizontal((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle _menu_horizontal_animated(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_menu_horizontal_animated");
fn ComponentHandle menu_horizontal_animated(ZString[] entries, CInt* selected) {
  return _menu_horizontal_animated((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle _menu_toggle(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_menu_toggle");
fn ComponentHandle menu_toggle(ZString[] entries, CInt* selected) {
  return _menu_toggle((CChar**)entries.ptr, entries.len, selected);
}
extern fn ComponentHandle _dropdown(
  CChar** entries,
  CInt count,
  CInt* selected)
@cname("ftxui_component_dropdown");
fn ComponentHandle dropdown(ZString[] entries, CInt* selected) {
  return _dropdown((CChar**)entries.ptr, entries.len, selected);
}
alias DropdownTransformCallback = fn ElementHandle(
  bool open,
  ElementHandle checkbox,
  ElementHandle radiobox,
  void* userdata);
extern fn ComponentHandle _dropdown_custom(
  CChar** entries,
  CInt count,
  CInt* selected,
  DropdownTransformCallback transform,
  void* transform_userdata,
  Destructor transform_destructor,
  ButtonTransform entry_transform,
  void* entry_transform_userdata,
  Destructor entry_transform_destructor)
@cname("ftxui_component_dropdown_custom");
fn ComponentHandle dropdown_custom(ZString[] entries, CInt* selected, DropdownTransformCallback transform_callback, void* transform_callback_userdata, Destructor transform_destructor, ButtonTransform entry_transform_callback, void* entry_transform_callback_userdata, Destructor entry_transform_destructor) {
  return _dropdown_custom((CChar**)entries.ptr, entries.len, selected, transform_callback, transform_callback_userdata, transform_destructor, entry_transform_callback, entry_transform_callback_userdata, entry_transform_destructor);
}
extern fn ComponentHandle container_vertical()
@cname("ftxui_component_container_vertical");
extern fn ComponentHandle container_vertical_focused(
  CInt* selector)
@cname("ftxui_component_container_vertical_focused");
extern fn ComponentHandle container_horizontal()
@cname("ftxui_component_container_horizontal");
extern fn ComponentHandle container_horizontal_focused(
  CInt* selector)
@cname("ftxui_component_container_horizontal_focused");
extern fn ComponentHandle container_tab(
  CInt* selected)
@cname("ftxui_component_container_tab");
extern fn ComponentHandle container_stacked()
@cname("ftxui_component_container_stacked");
extern fn void ComponentHandle.container_add(
  self,
  ComponentHandle child)
@cname("ftxui_container_add");
extern fn bool ComponentHandle.focused(
  self)
@cname("ftxui_component_focused");
extern fn bool ComponentHandle.active(
  self)
@cname("ftxui_component_active");
extern fn void ComponentHandle.take_focus(
  self)
@cname("ftxui_component_take_focus");
extern fn ComponentHandle ComponentHandle.active_child(
  self)
@cname("ftxui_component_active_child");
extern fn void ComponentHandle.set_active_child(
  self,
  ComponentHandle child)
@cname("ftxui_component_set_active_child");
<* `child` can either be a null or non-null value. *>
extern fn ComponentHandle renderer(
  ComponentHandle child,
  RenderCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_renderer");
alias FocusedRenderCallback = fn ElementHandle(
  bool focused,
  void* userdata);
extern fn ComponentHandle focusable_renderer_component(
  FocusedRenderCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_renderer_focusable");
alias InnerRenderCallback = fn ElementHandle(
  ElementHandle inner,
  void* userdata);
extern fn ComponentHandle ComponentHandle.renderer_with_inner(
  self,
  InnerRenderCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_renderer_with_inner");
extern fn ElementHandle ComponentHandle.render(
  self)
@cname("ftxui_component_render");
extern fn ComponentHandle AppHandle.component_poll(
  self,
  UserdataCallback on_poll,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_poll");
extern fn ComponentHandle collapsible_component(
  ZString label,
  ComponentHandle child,
  bool* show)
@cname("ftxui_component_collapsible");
extern fn ComponentHandle ComponentHandle.maybe(
  self,
  bool* show)
@cname("ftxui_component_maybe");
extern fn ComponentHandle ComponentHandle.maybe_fn(
  self,
  PredicateCallback predicate,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_maybe_fn");
extern fn ComponentHandle ComponentHandle.modal(
  self,
  ComponentHandle modal,
  bool* show_modal)
@cname("ftxui_component_modal");
extern fn ComponentHandle ComponentHandle.resizable_split_left(
  self,
  ComponentHandle back,
  CInt* main_size)
@cname("ftxui_component_resizable_split_left");
extern fn ComponentHandle ComponentHandle.resizable_split_right(
  self,
  ComponentHandle back,
  CInt* main_size)
@cname("ftxui_component_resizable_split_right");
extern fn ComponentHandle ComponentHandle.resizable_split_top(
  self,
  ComponentHandle back,
  CInt* main_size)
@cname("ftxui_component_resizable_split_top");
extern fn ComponentHandle ComponentHandle.resizable_split_bottom(
  self,
  ComponentHandle back,
  CInt* main_size)
@cname("ftxui_component_resizable_split_bottom");
alias SeparatorFunc = fn ElementHandle(
  void* userdata);
struct ResizableSplitOption {
  ComponentHandle main;
  ComponentHandle back;
  Direction direction;
  CInt* main_size;
  CInt* min_size;
  CInt* max_size;
  SeparatorFunc separator_func;
  void* separator_userdata;
  Destructor separator_destructor;
}
extern fn ComponentHandle component_resizable_split_opt(
  ResizableSplitOption option)
@cname("ftxui_component_resizable_split_opt");
struct WindowOptions {
  ComponentHandle inner;
  ZString title;
  CInt* left;
  CInt* top;
  CInt* width;
  CInt* height;
  CInt left_default;
  CInt top_default;
  CInt width_default;
  CInt height_default;
}
extern fn ComponentHandle window(
  WindowOptions options)
@cname("ftxui_component_window");
extern fn ComponentHandle ComponentHandle.hoverable(
  self,
  bool* hover)
@cname("ftxui_component_hoverable");
extern fn ComponentHandle ComponentHandle.hoverable_callbacks(
  self,
  Callback on_enter,
  void* on_enter_userdata,
  Destructor on_enter_destructor,
  Callback on_leave,
  void* on_leave_userdata,
  Destructor on_leave_destructor)
@cname("ftxui_component_hoverable_callbacks");
alias HoveredClosure @private = fn void(
  bool hovered,
  void* userdata);
extern fn ComponentHandle ComponentHandle.hoverable_change(
  self,
  HoveredClosure on_change,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_hoverable_change");
alias CatchEventCallback = fn bool(
  EventHandle event,
  void* userdata);
extern fn ComponentHandle ComponentHandle.catch_event(
  self,
  CatchEventCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_catch_event");
extern fn ComponentHandle ComponentHandle.post_catch_event(
  self,
  CatchEventCallback callback,
  void* userdata,
  Destructor destructor)
@cname("ftxui_component_post_catch_event");
extern fn void ComponentHandle.free(
  self)
@cname("ftxui_component_destroy");
extern fn ComponentHandle ComponentHandle.border(
  self)
@cname("ftxui_component_border");
extern fn ComponentHandle ComponentHandle.border_light(
  self)
@cname("ftxui_component_border_light");
extern fn ComponentHandle ComponentHandle.border_dashed(
  self)
@cname("ftxui_component_border_dashed");
extern fn ComponentHandle ComponentHandle.border_heavy(
  self)
@cname("ftxui_component_border_heavy");
extern fn ComponentHandle ComponentHandle.border_double(
  self)
@cname("ftxui_component_border_double");
extern fn ComponentHandle ComponentHandle.border_rounded(
  self)
@cname("ftxui_component_border_rounded");
extern fn ComponentHandle ComponentHandle.border_empty(
  self)
@cname("ftxui_component_border_empty");
extern fn ComponentHandle ComponentHandle.bold(
  self)
@cname("ftxui_component_bold");
extern fn ComponentHandle ComponentHandle.dim(
  self)
@cname("ftxui_component_dim");
extern fn ComponentHandle ComponentHandle.inverted(
  self)
@cname("ftxui_component_inverted");
extern fn ComponentHandle ComponentHandle.underlined(
  self)
@cname("ftxui_component_underlined");
extern fn ComponentHandle ComponentHandle.blink(
  self)
@cname("ftxui_component_blink");
extern fn ComponentHandle ComponentHandle.strikethrough(
  self)
@cname("ftxui_component_strikethrough");
extern fn ComponentHandle ComponentHandle.nothing(
  self)
@cname("ftxui_component_nothing");
extern fn ComponentHandle ComponentHandle.color(
  self,
  ColorHandle color)
@cname("ftxui_component_color");
extern fn ComponentHandle ComponentHandle.bgcolor(
  self,
  ColorHandle color)
@cname("ftxui_component_bgcolor");
extern fn ComponentHandle ComponentHandle.vscroll_indicator(
  self)
@cname("ftxui_component_vscroll_indicator");
extern fn ComponentHandle ComponentHandle.frame(
  self)
@cname("ftxui_component_frame");
extern fn ComponentHandle ComponentHandle.flex(
  self)
@cname("ftxui_component_flex");
extern fn ComponentHandle ComponentHandle.hcenter(
  self)
@cname("ftxui_component_hcenter");
extern fn ComponentHandle ComponentHandle.vcenter(
  self)
@cname("ftxui_component_vcenter");
extern fn ComponentHandle ComponentHandle.center(
  self)
@cname("ftxui_component_center");
extern fn ComponentHandle ComponentHandle.align_right(
  self)
@cname("ftxui_component_align_right");
extern fn ComponentHandle ComponentHandle.set_size(
  self,
  WidthOrHeight width_or_height,
  Constraint constraint_type,
  CInt value)
@cname("ftxui_component_set_size");
constdef MouseButton : CInt {
  FTXUI_MOUSE_BUTTON_LEFT = 0,
  FTXUI_MOUSE_BUTTON_MIDDLE = 1,
  FTXUI_MOUSE_BUTTON_RIGHT = 2,
  FTXUI_MOUSE_BUTTON_NONE = 3,
  FTXUI_MOUSE_BUTTON_WHEEL_UP = 4,
  FTXUI_MOUSE_BUTTON_WHEEL_DOWN = 5,
  FTXUI_MOUSE_BUTTON_WHEEL_LEFT = 6,
  FTXUI_MOUSE_BUTTON_WHEEL_RIGHT = 7
}
constdef MouseMotion : CInt {
  FTXUI_MOUSE_MOTION_RELEASED = 0,
  FTXUI_MOUSE_MOTION_PRESSED = 1,
  FTXUI_MOUSE_MOTION_MOVED = 2
}
extern fn ZString EventHandle.input(
  self)
@cname("ftxui_event_input");
extern fn ZString EventHandle.debug_string(
  self)
@cname("ftxui_event_debug_string");
extern fn bool EventHandle.is_character(
  self)
@cname("ftxui_event_is_character");
extern fn ZString EventHandle.character(
  self)
@cname("ftxui_event_character");
extern fn bool EventHandle.is_mouse(
  self)
@cname("ftxui_event_is_mouse");
extern fn CInt EventHandle.mouse_x(
  self)
@cname("ftxui_event_mouse_x");
extern fn CInt EventHandle.mouse_y(
  self)
@cname("ftxui_event_mouse_y");
extern fn MouseButton EventHandle.mouse_button(
  self)
@cname("ftxui_event_mouse_button");
extern fn MouseMotion EventHandle.mouse_motion(
  self)
@cname("ftxui_event_mouse_motion");
extern fn bool EventHandle.mouse_shift(
  self)
@cname("ftxui_event_mouse_shift");
extern fn bool EventHandle.mouse_meta(
  self)
@cname("ftxui_event_mouse_meta");
extern fn bool EventHandle.mouse_control(
  self)
@cname("ftxui_event_mouse_control");
extern fn bool EventHandle.is_cursor_position(
  self)
@cname("ftxui_event_is_cursor_position");
extern fn CInt EventHandle.cursor_x(
  self)
@cname("ftxui_event_cursor_x");
extern fn CInt EventHandle.cursor_y(
  self)
@cname("ftxui_event_cursor_y");
extern fn bool EventHandle.is_cursor_shape(
  self)
@cname("ftxui_event_is_cursor_shape");
extern fn CInt EventHandle.cursor_shape(
  self)
@cname("ftxui_event_cursor_shape");
extern fn bool EventHandle.is_terminal_name_version(
  self)
@cname("ftxui_event_is_terminal_name_version");
extern fn ZString EventHandle.terminal_name(
  self)
@cname("ftxui_event_terminal_name");
extern fn CInt EventHandle.terminal_version(
  self)
@cname("ftxui_event_terminal_version");
extern fn bool EventHandle.is_terminal_emulator(
  self)
@cname("ftxui_event_is_terminal_emulator");
extern fn ZString EventHandle.terminal_emulator_name(
  self)
@cname("ftxui_event_terminal_emulator_name");
extern fn ZString EventHandle.terminal_emulator_version(
  self)
@cname("ftxui_event_terminal_emulator_version");
extern fn bool EventHandle.is_terminal_capabilities(
  self)
@cname("ftxui_event_is_terminal_capabilities");
extern fn CInt* EventHandle.terminal_capabilities(
  self,
  CInt* count)
@cname("ftxui_event_terminal_capabilities");
extern fn void EventHandle.free(
  self)
@cname("ftxui_event_destroy");
extern fn bool EventHandle.equal(
  self,
  EventHandle other)
@cname("ftxui_event_equal");
extern fn EventHandle event_arrow_left()
@cname("ftxui_event_arrow_left");
extern fn EventHandle event_arrow_right()
@cname("ftxui_event_arrow_right");
extern fn EventHandle event_arrow_up()
@cname("ftxui_event_arrow_up");
extern fn EventHandle event_arrow_down()
@cname("ftxui_event_arrow_down");
extern fn EventHandle event_arrow_left_ctrl()
@cname("ftxui_event_arrow_left_ctrl");
extern fn EventHandle event_arrow_right_ctrl()
@cname("ftxui_event_arrow_right_ctrl");
extern fn EventHandle event_arrow_up_ctrl()
@cname("ftxui_event_arrow_up_ctrl");
extern fn EventHandle event_arrow_down_ctrl()
@cname("ftxui_event_arrow_down_ctrl");
extern fn EventHandle event_backspace()
@cname("ftxui_event_backspace");
extern fn EventHandle event_delete()
@cname("ftxui_event_delete");
extern fn EventHandle event_return()
@cname("ftxui_event_return");
extern fn EventHandle event_escape()
@cname("ftxui_event_escape");
extern fn EventHandle event_tab()
@cname("ftxui_event_tab");
extern fn EventHandle event_tab_reverse()
@cname("ftxui_event_tab_reverse");
extern fn EventHandle event_insert()
@cname("ftxui_event_insert");
extern fn EventHandle event_home()
@cname("ftxui_event_home");
extern fn EventHandle event_end()
@cname("ftxui_event_end");
extern fn EventHandle event_page_up()
@cname("ftxui_event_page_up");
extern fn EventHandle event_page_down()
@cname("ftxui_event_page_down");
extern fn EventHandle event_f1()
@cname("ftxui_event_f1");
extern fn EventHandle event_f2()
@cname("ftxui_event_f2");
extern fn EventHandle event_f3()
@cname("ftxui_event_f3");
extern fn EventHandle event_f4()
@cname("ftxui_event_f4");
extern fn EventHandle event_f5()
@cname("ftxui_event_f5");
extern fn EventHandle event_f6()
@cname("ftxui_event_f6");
extern fn EventHandle event_f7()
@cname("ftxui_event_f7");
extern fn EventHandle event_f8()
@cname("ftxui_event_f8");
extern fn EventHandle event_f9()
@cname("ftxui_event_f9");
extern fn EventHandle event_f10()
@cname("ftxui_event_f10");
extern fn EventHandle event_f11()
@cname("ftxui_event_f11");
extern fn EventHandle event_f12()
@cname("ftxui_event_f12");
extern fn EventHandle event_custom()
@cname("ftxui_event_custom");
extern fn EventHandle event_character_from_char(
  CChar c)
@cname("ftxui_event_character_from_char");
extern fn EventHandle event_special(
  ZString input)
@cname("ftxui_event_special");
extern fn EventHandle event_ctrl_char(
  CChar c)
@cname("ftxui_event_ctrl_char");
extern fn EventHandle event_alt_char(
  CChar c)
@cname("ftxui_event_alt_char");
extern fn EasingFunction easing_function_get(
  EasingFunctionType type)
@cname("ftxui_easing_function_get");