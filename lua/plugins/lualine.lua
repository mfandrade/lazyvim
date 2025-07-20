-- lua/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy", -- Garante que o Lualine seja carregado no momento certo
  opts = function(_, opts)
    -- Carrega a paleta de cores do Catppuccin
    local catppuccin = require("catppuccin.palettes").get_palette()

    -- Mantém sua configuração existente para desativar lualine_z
    opts.sections = opts.sections or {}
    opts.sections.lualine_z = {}

    -- Garante que opts.options existe
    opts.options = opts.options or {}

    -- *** CORREÇÃO PRINCIPAL AQUI ***
    -- Verifica se opts.options.theme é uma string (nome do tema)
    -- Se for, converte para uma tabela e define o tema padrão do lualine.
    if type(opts.options.theme) == "string" then
      local theme_name = opts.options.theme
      opts.options.theme = require("lualine.themes." .. theme_name) or {}
      -- O lualine armazena seus temas padrão em lualine.themes.<nome_do_tema>
      -- Pegamos o tema padrão e o transformamos em uma tabela para poder modificá-lo.
    end

    -- Garante que opts.options.theme é uma tabela
    opts.options.theme = opts.options.theme or {}

    -- Herda as configurações do tema Catppuccin Mocha padrão para os estados normal e inativo
    -- Agora, 'opts.options.theme.normal' e 'inactive' devem existir ou serão nil,
    -- o que é aceitável, pois o Lualine usará seus defaults se forem nil.
    -- Essas linhas podem ser removidas se você não estiver personalizando explicitamente.
    -- opts.options.theme.normal = opts.options.theme.normal
    -- opts.options.theme.inactive = opts.options.theme.inactive

    -- Configura as cores para o modo 'Insert'
    -- 'a' é a seção que normalmente exibe o nome do modo (ex: "INSERT")
    opts.options.theme.insert = {
      a = { fg = catppuccin.red, bg = catppuccin.base }, -- Texto 'red', fundo 'base'
      -- As outras seções (b, c) manterão o estilo padrão do tema Catppuccin para o modo insert,
      -- a menos que você as customize aqui também.
    }

    -- Se quiser customizar outros modos (ex: 'visual', 'replace', 'command'), adicione-os aqui:
    -- opts.options.theme.visual = { a = { fg = catppuccin.lavender, bg = catppuccin.base } }
    -- opts.options.theme.replace = { a = { fg = catppuccin.red, bg = catppuccin.base } }
    -- opts.options.theme.command = { a = { fg = catppuccin.sapphire, bg = catppuccin.base } }

    return opts
  end,
}
