local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
    s("boiler", {
        t({"<!DOCTYPE html>",
            '<html lang="en">',
        "  <head>",
        '    <meta charset="UTF-8">'
        ,""}),
        t("    <title>"), i(1), t({"</title>"}),
        t({"", "  </head>",
            "  <body>"}),
        i(0, ""),
        t({"", "  </body>",
            "</html>"}),
    }),
}


