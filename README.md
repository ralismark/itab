# Itab v1.0.1

*Ending the tabs/spaces war by using both*

This plugin was developed from the original [Smart-Tabs][1], but expanded upon
significantly and generally fixed. That original script describes its purpose
best:

> The aim of this script is to be able to handle the mode of tab usage which
> distinguishes 'indent' from 'alignment'. The idea is to use <tab> characters
> only at the beginning of lines.
>
> This means that an individual can use their own 'tabstop' settings for the
> indent level, while not affecting alignment.

 [1]: https://github.com/vim-scripts/Smart-Tabs

## Behaviour

When indenting (e.g. on a new line, `==`, etc.), the existing indentation is
replaced by the correct combination of tabs and spaces. The way that this is
done may break some features (most notably the x flag in `format-comments`).

This plugin also overrides tab to insert spaces up to a tabstop when not at the
beginning of a line. The tab key has the default behaviour when at the beginning
of the line.

Along with key mapping, the plugin also provides several `<Plug>` mappings in
case you want to extend behaviour:

- `<Plug>ItabEsc` - Delete trailing spaces, then return to insert mode. Replaces `i_<Esc>`.
- `<Plug>ItabTab` - Insert smart tab. Replaces `i_<Tab>`
- `<Plug>ItabCr` - Go to new line, deleting trailing space and then indenting
  correctly. Replaces `i_<Cr>`
- `<Plug>ItabRealign` - Fix an empty line's indent. Used after several normal
  mode commands which create blank lines (e.g. `o`, `O`, `S`, `cc`).

## Options

- `itab#disable_all_maps` - Disable mapping of any keys
- `itab#disable_maps` - Disable mapping of tab
- `itab#clear_trails` - Delete trailing whitespace when going to a new line
  after indenting

## Issues

While I have been using this plugin as part of my workflow, I have not
thoroughly tested its behaviour and interactions with vim features. If you find
any issues, please create an issue on github.
