# colors.nix
#-------------------------------------------------------------------------------
# Color palette and semantic mappings - SINGLE SOURCE OF TRUTH
#-------------------------------------------------------------------------------
{ lib, ... }:

{
  programs.nixvim.colorschemes.tokyonight.enable = lib.mkForce false;

  programs.nixvim.extraConfigLua = lib.mkBefore ''
    ---------------------------------------------------------------------------
    -- Color Palette
    ---------------------------------------------------------------------------
    _G.C = {
      -- Blues
      LightBlue = "#51afef",
      Turquoise = "#64b4dc",
      MutedBlue = "#83A8C1",
      DarkBlue = "#4784DF",
      CommentBlue = "#609199",
      Cyan = "#00e6e6",
      CmpBlue = "#569CD6",
      CmpLightBlue = "#9CDCFE",

      -- Greens
      SpringGreen = "#78b830",
      MossGreen = "#7db74d",
      Army = "#8ca375",
      InsertGreen = "#c3e88d",

      -- Purples
      LightPurple = "#A270A7",
      DeepPurple = "#8048b0",
      MutedPurple = "#BA5D7E",
      Magenta = "#c678dd",
      CmpPink = "#C586C0",
      VisualPurple = "#c792ea",

      -- Reds
      DarkRed = "#CF745D",
      BrightRed = "#cc544b",
      RusticRed = "#C06050",
      DimPink = "#e67e7e",
      CmpRed = "#e06c75",
      ReplaceRed = "#f07178",

      -- Yellows/Browns/Orange
      Lemon = "#DBd263",
      GoldenRay = "#A07A2F",
      HarvestGold = "#D0C050",
      OliveTwist = "#B9BA1E",
      BronzeDawn = "#CBAA46",
      AncientGold = "#bc990c",
      MutedYellow = "#A79414",
      Orange = "#D4AC0D",
      SearchOrangeBg = "#45413B",
      SearchOrangeFg = "#ffa724",

      -- Grays
      DarkGray = "#878787",
      GrayCloud = "#A8A8A8",
      NearBlack = "#202020",
      Black = "#212121",
      DarkerBlack = "#282c34",
      MaterialBg = "#263238",
      MaterialBgAlt = "#2E3C43",
      MaterialGray = "#515559",
      White = "#c8c8c8",
      BrightWhite = "#eeffff",
      WhiteYellow = "#d1d0a5",
      WhiteRed = "#cc9999",
      CmpGray = "#808080",
      CmpFront = "#D4D4D4",

      -- Luci brand
      LuciPrimary = "#52A5B8",
      LuciPrimaryDark = "#19788E",
      LuciSecondary = "#FFA868",
      LuciSecondaryDark = "#F17417",
    }

    ---------------------------------------------------------------------------
    -- Semantic Mappings (roles → colors)
    ---------------------------------------------------------------------------
    _G.S = {
      -- Types
      Type = _G.C.AncientGold,
      TypeBuiltin = _G.C.GoldenRay,
      TypeDef = _G.C.Lemon,
      TypeAlias = _G.C.OliveTwist,
      TypeTag = _G.C.MutedPurple,

      -- Identifiers
      Identifier = _G.C.BronzeDawn,
      Parameter = _G.C.Lemon,
      Field = _G.C.GoldenRay,
      Variable = _G.C.BronzeDawn,
      VariableBuiltin = _G.C.DeepPurple,

      -- Functions
      Func = _G.C.LightBlue,
      FuncCall = _G.C.Turquoise,
      FuncMethod = _G.C.OliveTwist,
      FuncBuiltin = _G.C.AncientGold,

      -- Strings
      String = _G.C.MossGreen,
      StringBright = _G.C.SpringGreen,

      -- Comments
      Comment = _G.C.CommentBlue,
      Documentation = _G.C.Army,

      -- Language constructs
      Keyword = _G.C.MutedBlue,
      Macro = _G.C.DarkRed,
      Trait = _G.C.LightPurple,
      Lifetime = _G.C.SpringGreen,
      Namespace = _G.C.DarkGray,
      MyLib = _G.C.DarkBlue,
      Constant = _G.C.RusticRed,
      ConstantLang = _G.C.Orange,

      -- Punctuation
      Delimiter = _G.C.GrayCloud,

      -- Diagnostics/Errors
      Error = _G.C.BrightRed,
      Warning = "#B79632",
      Info = _G.C.GrayCloud,
      Hint = "#588080",

      -- UI
      Normal = _G.C.GrayCloud,
      Dim = _G.C.DarkGray,
      Accent = _G.C.BrightRed,
      Visual = _G.C.Cyan,
      Match = _G.C.White,
      MatchBg = _G.C.LuciPrimaryDark,
      Search = _G.C.SearchOrangeFg,
      SearchBg = _G.C.SearchOrangeBg,
      LineNr = _G.C.HarvestGold,
      StatusLine = _G.C.LuciPrimary,
      VertSplit = _G.C.LuciPrimary,
      Title = _G.C.DeepPurple,

      -- Backgrounds
      BgNone = "NONE",
      BgDark = _G.C.NearBlack,
      BgFloat = _G.C.Black,
      BgSelected = "#3e4451",
      BgDarker = _G.C.DarkerBlack,
    }
  '';
}
