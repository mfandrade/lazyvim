return {
  "nat-418/boole.nvim",
  config = function()
    require("boole").setup({
      mappings = {
        increment = "<C-a>",
        decrement = "<C-x>",
      },
      additions = {
        -- stylua: ignore start
        { "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" },
        { "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday" },
        { "Dom", "Seg", "Ter", "Qua", "Qui", "Sex", "Sab" },
        { "Domingo", "Segunda", "Terça", "Quarta", "Quinta", "Sexta", "Sábado" },
        { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" },
        { "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December", },
        { "Jan", "Fev", "Mar", "Abr", "Mai", "Jun", "Jul", "Ago", "Set", "Out", "Nov", "Dez" },
        { "Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro", },
        { "on", "off" },
        -- stylua: ignore end
      },
      allow_caps_additions = {
        { "true", "false" },
        { "left", "down", "up", "right" },
      },
    })
  end,
}
