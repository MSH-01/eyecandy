# Eyecandy Theme for Zed

This theme is beauty, taste and old money.

## Screenshots

<img width="3248" height="2028" alt="light mode" src="https://github.com/user-attachments/assets/24aa0f66-b97c-4a8b-a994-c1aeb295f49b" />


<img width="3248" height="2028" alt="dark mode" src="https://github.com/user-attachments/assets/19d78ab8-c1f2-4464-9ea9-1d6cd7c2302a" />




## Installation

1. Zed Menu -> Extensions -> Search "Eyecandy"
2. Click `Install`
3. Select the **Eyecandy** theme in the Zed editor.

### Neovim

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "MSH-01/eyecandy",
  lazy = false,
  priority = 1000,
  config = function()
    vim.o.termguicolors = true
    vim.cmd.colorscheme("eyecandy")
  end,
}
```

It follows `'background'`, so `:set background=light` switches to the light variant. Leave `'background'` unset and Neovim picks it up from your terminal.

## Contribution

If you have any suggestions or issues regarding this theme, feel free to submit an issue or pull request on GitHub.

## License

This theme is licensed under the MIT License.

Big up yourself one time for using the **Eyecandy** theme.
