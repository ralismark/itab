# Itab v1.1.0

*Ending the tabs/spaces war by using both*

This plugin was developed from the original [Smart-Tabs][1], but uses a new and
simpler method for getting the correct indentation. That original script
describes its purpose best:

> The aim of this script is to be able to handle the mode of tab usage which
> distinguishes 'indent' from 'alignment'. The idea is to use <tab> characters
> only at the beginning of lines.
>
> This means that an individual can use their own 'tabstop' settings for the
> indent level, while not affecting alignment.

 [1]: https://github.com/vim-scripts/Smart-Tabs

## Behaviour

When indenting (e.g. on a new line, `==`, etc.), the existing indentation is
replaced by the correct combination of tabs and spaces. This is done by using a
large `shiftwidth` and `tabstop`.

Along with key mapping, the plugin also provides several `<Plug>` mappings in
case you want to extend behaviour:

- `<Plug>ItabTab` - Insert smart tab. Replaces `i_<Tab>`
- `<Plug>ItabCr` - Go to new line, deleting trailing space and then indenting
  correctly. Replaces `i_<Cr>`

## Extending

This behaviour can be used with other keys. For insert mode mappings (replace
`<Key>` with the appropriate key):

```
inoremap <silent><expr> <Key> itab#doaction("<Key>")
```

Similarly, for normal/visual mode:

```
noremap <silent><expr> <Key> itab#ndoaction("<Key>")
```

If you're mapping an operator, you will need to define an additional function -
see the code for `itab#equalop`, and replace `=` with the appropriate key
sequence.

## Options

- `itab#disable_all_maps` - Disable mapping of any keys (will keep `<Plug>`)
- `itab#disable_maps` - Disable mapping of tab

## Issues

While I have been using this plugin as part of my workflow, I have not
thoroughly tested its behaviour and interactions with vim features. If you find
any issues, please create an issue on github.
