local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

-- in_mathzone returns v:true/v:false, which may surface as boolean or 1/0
local function in_math()
  local r = vim.fn["vimtex#syntax#in_mathzone"]()
  return r == true or r == 1
end
local function not_math()
  return not in_math()
end

local m = { condition = in_math, show_condition = in_math }

local snippets = {}

local autosnippets = {
  -- entering math
  s({ trig = "mk", snippetType = "autosnippet", condition = not_math }, fmta("$<>$<>", { i(1), i(0) })),
  s({ trig = "dm", snippetType = "autosnippet", condition = not_math }, fmta("\\[\n  <>\n\\]\n<>", { i(1), i(0) })),

  -- structure
  s(vim.tbl_extend("force", { trig = "ff", snippetType = "autosnippet" }, m), fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  s(vim.tbl_extend("force", { trig = "sq", snippetType = "autosnippet" }, m), fmta("\\sqrt{<>}", { i(1) })),
  s(vim.tbl_extend("force", { trig = "td", snippetType = "autosnippet" }, m), fmta("^{<>}", { i(1) })),
  s(vim.tbl_extend("force", { trig = "__", snippetType = "autosnippet" }, m), fmta("_{<>}", { i(1) })),
  s(vim.tbl_extend("force", { trig = "sr", snippetType = "autosnippet" }, m), t("^2")),

  -- big operators
  s(
    vim.tbl_extend("force", { trig = "sum", snippetType = "autosnippet" }, m),
    fmta("\\sum_{<>}^{<>}", { i(1, "n=1"), i(2, "\\infty") })
  ),
  s(
    vim.tbl_extend("force", { trig = "int", snippetType = "autosnippet" }, m),
    fmta("\\int_{<>}^{<>}", { i(1, "-\\infty"), i(2, "\\infty") })
  ),
  s(
    vim.tbl_extend("force", { trig = "lim", snippetType = "autosnippet" }, m),
    fmta("\\lim_{<> \\to <>}", { i(1, "n"), i(2, "\\infty") })
  ),

  -- relations
  s(vim.tbl_extend("force", { trig = "!=", snippetType = "autosnippet" }, m), t("\\neq")),
  s(vim.tbl_extend("force", { trig = "<=", snippetType = "autosnippet" }, m), t("\\leq")),
  s(vim.tbl_extend("force", { trig = ">=", snippetType = "autosnippet" }, m), t("\\geq")),
  s(vim.tbl_extend("force", { trig = "->", snippetType = "autosnippet" }, m), t("\\to")),
  s(vim.tbl_extend("force", { trig = "=>", snippetType = "autosnippet" }, m), t("\\implies")),
  s(vim.tbl_extend("force", { trig = "inn", snippetType = "autosnippet" }, m), t("\\in")),
}

return snippets, autosnippets
