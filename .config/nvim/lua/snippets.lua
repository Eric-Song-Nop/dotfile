local M = {
    setup_snippets = function()
        local ls = require "luasnip"
        local s = ls.snippet
        local t = ls.text_node
        local i = ls.insert_node
        ls.add_snippets("cpp", {
            s("leet", {
                t {
                    "#include <bits/stdc++.h>",
                    "#include <string>",
                    "using namespace std;",
                    "class Solution",
                    "{",
                    "  public:",
                    "",
                },
                i(1, "func"),
                t {
                    "",
                    "};",
                    "",
                    "int main(int argc, char *argv[])",
                    "{",
                    "    return 0;",
                    "}",
                },
            }),
        })
        require("luasnip.loaders.from_lua").lazy_load { include = { "all", "cpp" } }
    end,
}

return M
