%%
%% This is file `bisuthesis.cls',
%% adapted from `thuthesis.cls' by Tsinghua University TUNA Association.
%%
%% Original source: thuthesis.dtx (with options: `cls')
%% Original project: https://github.com/tuna/thuthesis
%%
%% Copyright (C) 2005-2021 by Tsinghua University TUNA Association
%%   <tuna@tsinghua.edu.cn>
%%
%% Modifications for BISU (Beijing International Studies University):
%%   Copyright (C) 2026 by xuwudawei (https://github.com/xuwudawei)
%%   - Renamed from thuthesis to bisuthesis
%%   - Adapted formatting for BISU thesis requirements
%%
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008 or later.
%%
\NeedsTeXFormat{LaTeX2e}[2017/04/15]
\ProvidesClass{bisuthesis}
[2026/02/27 1.0.0 BISU Thesis Template (based on ThuThesis 7.2.2)]
\newcommand\bisu@error[1]{%
  \ClassError{bisuthesis}{#1}{}%
}
\newcommand\bisu@warning[1]{%
  \ClassWarning{bisuthesis}{#1}%
}
\newcommand\bisu@patch@error[1]{%
  \bisu@error{Failed to patch command \protect#1}%
}
\newcommand\bisu@deprecate[2]{%
  \def\bisu@@tmp{#2}%
  \bisu@warning{%
    The #1 is deprecated%
    \ifx\bisu@@tmp\@empty\else
      . Use #2 instead%
    \fi
  }%
}
\@ifl@t@r\fmtversion{2017/04/15}{}{
  \bisu@error{%
    TeX Live 2017 or later version is required to compile this document%
  }
}
\RequirePackage{iftex}
\ifXeTeX\else
  \bisu@error{XeLaTeX is required to compile this document}
\fi
\InputIfFileExists{bisuthesis-pdf-test-config.tex}{}{
  \InputIfFileExists{bisuthesis-log-test-config.tex}{}{}
}
\hyphenation{Bisu-Thesis}
\def\bisuthesis{BisuThesis}
\def\version{7.2.2}
\RequirePackage{kvdefinekeys}
\RequirePackage{kvsetkeys}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=bisu,
  prefix=bisu@,
  setkeys=\kvsetkeys}
\let\bisu@setup@hook\@empty
\newcommand\bisusetup[1]{%
  \let\bisu@setup@hook\@empty
  \kvsetkeys{bisu}{#1}%
  \bisu@setup@hook
}
\newcommand\bisu@define@key[1]{%
  \kvsetkeys{bisu@key}{#1}%
}
\kv@set@family@handler{bisu@key}{%
  \@namedef{bisu@#1@@name}{#1}%
  \def\bisu@@default{}%
  \def\bisu@@choices{}%
  \kv@define@key{bisu@value}{name}{%
    \@namedef{bisu@#1@@name}{##1}%
  }%
  \@namedef{bisu@#1@@check}{}%
  \@namedef{bisu@#1@@code}{}%
  \kv@define@key{bisu@value}{choices}{%
    \def\bisu@@choices{##1}%
    \@namedef{bisu@#1@@reset}{}%
    \@namedef{bisu@#1@@check}{%
      \@ifundefined{%
        ifbisu@\@nameuse{bisu@#1@@name}@\@nameuse{bisu@\@nameuse{bisu@#1@@name}}%
      }{%
        \bisu@error{Invalid value "#1 = \@nameuse{bisu@\@nameuse{bisu@#1@@name}}"}%
      }%
      \@nameuse{bisu@#1@@reset}%
      \@nameuse{bisu@\@nameuse{bisu@#1@@name}@\@nameuse{bisu@\@nameuse{bisu@#1@@name}}true}%
    }%
  }%
  \kv@define@key{bisu@value}{default}{%
    \def\bisu@@default{##1}%
  }%
  \kvsetkeys{bisu@value}{#2}%
  \@namedef{bisu@\@nameuse{bisu@#1@@name}}{}%
  \kv@set@family@handler{bisu@choice}{%
    \ifx\bisu@@default\@empty
      \def\bisu@@default{##1}%
    \fi
    \expandafter\newif\csname ifbisu@\@nameuse{bisu@#1@@name}@##1\endcsname
    \expandafter\g@addto@macro\csname bisu@#1@@reset\endcsname{%
      \@nameuse{bisu@\@nameuse{bisu@#1@@name}@##1false}%
    }%
  }%
  \kvsetkeys@expandafter{bisu@choice}{\bisu@@choices}%
  \expandafter\let\csname bisu@\@nameuse{bisu@#1@@name}\endcsname\bisu@@default
  \expandafter\ifx\csname bisu@\@nameuse{bisu@#1@@name}\endcsname\@empty\else
    \@nameuse{bisu@#1@@check}%
  \fi
  \kv@define@key{bisu}{#1}{%
    \@namedef{bisu@\@nameuse{bisu@#1@@name}}{##1}%
    \@nameuse{bisu@#1@@check}%
    \@nameuse{bisu@#1@@code}%
  }%
}
\newcommand\bisu@option@hook[2]{%
  \expandafter\g@addto@macro\csname bisu@#1@@code\endcsname{#2}%
}
\bisu@define@key{
  thesis-type = {
    name = thesis@type,
    choices = {
      thesis,
      proposal,
    },
    default = thesis,
  },
  degree = {
    choices = {
      bachelor,
      master,
      doctor,
      postdoc,
    },
    default = doctor,
  },
  degree-type = {
    choices = {
      academic,
      professional,
    },
    name = degree@type,
  },
  main-language = {
    name = main@language,
    choices = {
      chinese,
      english,
    },
  },
  language = {
    choices = {
      chinese,
      english,
    },
  },
  system = {
    choices = {
      auto,
      mac,
      unix,
      windows,
    },
    default = auto,
  },
  fontset = {
    choices = {
      auto,
      windows,
      mac,
      ubuntu,
      fandol,
      none,
    },
    default = auto,
  },
  font = {
    choices = {
      auto,
      times,
      termes,
      stix,
      xits,
      libertinus,
      newcm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  cjk-font = {
    name = cjk@font,
    choices = {
      auto,
      windows,
      mac,
      noto,
      fandol,
      none,
    },
    default = auto,
  },
  math-font = {
    name = math@font,
    choices = {
      auto,
      stix,
      xits,
      libertinus,
      newcm,
      lm,
      newtx,
      none,
    },
    default = auto,
  },
  math-style = {
    name = math@style,
    choices = {
      GB,
      ISO,
      TeX,
    },
  },
  uppercase-greek = {
    name = uppercase@greek,
    choices = {
      italic,
      upright,
    },
  },
  less-than-or-equal = {
    name = leq,
    choices = {
      slanted,
      horizontal,
    },
  },
  integral = {
    choices = {
      upright,
      slanted,
    },
  },
  integral-limits = {
    name = integral@limits,
    choices = {
      true,
      false,
    },
  },
  partial = {
    choices = {
      upright,
      italic,
    },
  },
  math-ellipsis = {
    name = math@ellipsis,
    choices = {
      centered,
      lower,
      AMS,
    },
  },
  real-part = {
    name = real@part,
    choices = {
      roman,
      fraktur,
    },
  },
  output = {
    choices = {
      print,
      electronic,
    },
    default = print,
  },
}
\newif\ifbisu@degree@graduate
\newcommand\bisu@set@graduate{%
  \bisu@degree@graduatefalse
  \ifbisu@degree@doctor
    \bisu@degree@graduatetrue
  \fi
  \ifbisu@degree@master
    \bisu@degree@graduatetrue
  \fi
}
\bisu@set@graduate
\bisu@option@hook{degree}{%
  \bisu@set@graduate
}
\DeclareBoolOption[false]{openright}
\DeclareComplementaryOption{openany}{openright}
\DeclareBoolOption[true]{raggedbottom}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\ifbisu@openright
  \PassOptionsToClass{openright}{book}
\else
  \PassOptionsToClass{openany}{book}
\fi
\PassOptionsToPackage{no-math}{fontspec}
\LoadClass[a4paper,UTF8,zihao=-4,scheme=plain,fontset=none]{ctexbook}[2017/04/01]
\RequirePackage{etoolbox}
\RequirePackage{filehook}
\RequirePackage{xparse}
\RequirePackage{geometry}%
\RequirePackage{fancyhdr}
\RequirePackage{titletoc}
\RequirePackage{notoccite}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage[labelformat=simple]{subcaption}
\RequirePackage{pdfpages}
\includepdfset{fitpaper=true}
\RequirePackage[shortlabels]{enumitem}
\RequirePackage{environ}
\ifbisu@raggedbottom
  \RequirePackage[bottom,perpage,hang]{footmisc}
  \raggedbottom
\else
  \RequirePackage[perpage,hang]{footmisc}
\fi
\RequirePackage{xeCJKfntef}
\RequirePackage{soul}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{url}
\AtEndPreamble{
  \@ifpackageloaded{biblatex}{}{
    \@ifpackageloaded{apacite}{}{
      \RequirePackage{natbib}
    }
  }
}
\AtEndOfPackageFile*{natbib}{
  \@ifpackageloaded{apacite}{}{
    \RequirePackage{bibunits}
  }
}
\newcommand\bisu@package@conflict[2]{%
  \AtEndOfPackageFile*{#1}{%
    \AtBeginOfPackageFile*{#2}{%
      \bisu@error{The "#2" package is incompatible with "#1"}%
    }%
  }%
}
\bisu@package@conflict{biblatex}{bibunits}
\bisu@package@conflict{biblatex}{chapterbib}
\bisu@package@conflict{biblatex}{cite}
\bisu@package@conflict{biblatex}{multibib}
\bisu@package@conflict{biblatex}{natbib}

\bisu@package@conflict{bibunits}{biblatex}
\bisu@package@conflict{bibunits}{chapterbib}
\bisu@package@conflict{bibunits}{multibib}

\bisu@package@conflict{unicode-math}{amscd}
\bisu@package@conflict{unicode-math}{amsfonts}
\bisu@package@conflict{unicode-math}{amssymb}
\bisu@package@conflict{unicode-math}{bbm}
\bisu@package@conflict{unicode-math}{bm}
\bisu@package@conflict{unicode-math}{eucal}
\bisu@package@conflict{unicode-math}{eufrak}
\bisu@package@conflict{unicode-math}{mathrsfs}
\bisu@package@conflict{unicode-math}{newtxmath}
\bisu@package@conflict{unicode-math}{upgreek}

\bisu@package@conflict{natbib}{biblatex}
\bisu@package@conflict{natbib}{cite}

\bisu@package@conflict{newtxmath}{amsfonts}
\bisu@package@conflict{newtxmath}{amssymb}
\bisu@package@conflict{newtxmath}{unicode-math}
\bisu@package@conflict{newtxmath}{upgreek}
\AtBeginOfPackageFile*{mathtools}{
  \@ifpackageloaded{unicode-math}{
    \bisu@error{The "mathtools" package should be loaded before setting "math-font"}
  }{}
}%
\AtBeginOfPackageFile*{amsthm}{
  \@ifpackageloaded{newtxmath}{
    \bisu@error{The "amsthm" package should be loaded before setting "newtxmath"}
  }{}
}%
\geometry{
  paper          = a4paper,  % 210 * 297mm
  marginparwidth = 2cm,
  marginparsep   = 0.5cm,
}
\newcommand\bisu@set@geometry{%
  \ifbisu@degree@bachelor
    \geometry{
      top        = 3.8cm,
      bottom     = 3.2cm,
      left       = 3.2cm,
      right      = 3cm,
      headheight = 0.5cm,
      headsep    = 1.8cm,
      footskip   = 1.45cm,
    }%
    \ifbisu@output@print
      \geometry{
        left       = 3.2cm,
        right      = 3cm,
      }%
    \else
      \geometry{
        hmargin    = 3cm,
      }%
    \fi
  \else
    \geometry{
      margin     = 3cm,
      headheight = 0.5cm,
      headsep    = 0.3cm,
      footskip   = 0.8cm,
    }%
  \fi
}
\bisu@set@geometry
\bisu@option@hook{degree}{\bisu@set@geometry}
\bisu@option@hook{output}{\bisu@set@geometry}
\bisusetup{main-language=\bisu@language}%
\let\bisu@main@language\bisu@language
\bisu@option@hook{language}{%
  \ifx\@begindocumenthook\@undefined\else
    \bisusetup{main-language=\bisu@language}%
    \let\bisu@main@language\bisu@language
  \fi
}
\newcommand\bisu@reset@main@language{%
  \bisusetup{language = \bisu@main@language}%
  \let\bisu@language\bisu@main@language
}
\newcommand\bisu@set@chapter@names{%
  \ifbisu@main@language@chinese
    \def\bisu@comments@name{指导教师学术评语}%
    \def\bibname{参考文献}%
    \def\appendixname{附录}%
    \def\indexname{索引}%
    \def\bisu@resolution@name{答辩委员会决议书}%
    \ifbisu@degree@bachelor
      \def\contentsname{目\qquad 录}%
      \def\listfigurename{插图索引}%
      \def\listtablename{表格索引}%
      \def\bisu@list@figure@table@name{插图和附表索引}%
      \def\bisu@list@algorithm@name{算法索引}%
      \def\bisu@acknowledgements@name{致\qquad 谢}%
      \def\listequationname{公式索引}%
      \def\bisu@denotation@name{主要符号对照表}%
      \def\bisu@resume@name{在学期间参加课题的研究成果}%
    \else
      \def\listfigurename{插图清单}%
      \def\listtablename{附表清单}%
      \def\bisu@list@figure@table@name{插图和附表清单}%
      \def\bisu@list@algorithm@name{算法清单}%
      \def\listequationname{公式清单}%
      \def\bisu@acknowledgements@name{致\quad 谢}%
      \ifbisu@degree@graduate
        \def\contentsname{目\quad 录}%
        \def\bisu@denotation@name{符号和缩略语说明}%
        \def\bisu@resume@name{个人简历、在学期间完成的相关学术成果}%
      \else  % degree = postdoc
        \def\contentsname{目\qquad 次}%
        \def\bisu@denotation@name{符号表}%
        \def\bisu@resume@name{个人简历、发表的学术论文与科研成果}%
      \fi
    \fi
  \else
    \ifbisu@main@language@english
      \def\bisu@comments@name{Comments from Thesis Supervisor}%
      \def\bisu@resolution@name{Resolution of Thesis Defense Committee}%
      \def\indexname{Index}%
      \ifbisu@degree@bachelor
        \def\contentsname{CONTENTS}%
        \def\listfigurename{FIGURES}%
        \def\listtablename{TABLES}%
        \def\bisu@list@figure@table@name{FIGURES AND TABLES}%
        \def\bisu@list@algorithm@name{ALGORITHMS}%
        \def\listequationname{EQUATIONS}%
        \def\bisu@denotation@name{ABBREVIATIONS}%
        \def\bibname{REFERENCES}%
        \def\appendixname{APPENDIX}%
        \def\bisu@acknowledgements@name{ACKNOWLEDGEMENTS}%
        \def\bisu@resume@name{PUBLICATIONS}%
      \else
        \def\contentsname{Table of Contents}%
        \def\listfigurename{List of Figures}%
        \def\listtablename{List of Tables}%
        \def\bisu@list@figure@table@name{List of Figures and Tables}%
        \def\bisu@list@algorithm@name{List of Algorithms}%
        \def\listequationname{List of Equations}%
        \def\bisu@denotation@name{List of Symbols and Acronyms}%
        \def\bibname{References}%
        \def\appendixname{Appendix}%
        \def\bisu@acknowledgements@name{Acknowledgements}%
        \def\bisu@resume@name{Resume}%
      \fi
    \fi
  \fi
}
\bisu@set@chapter@names
\bisu@option@hook{degree}{\bisu@set@chapter@names}
\bisu@option@hook{main-language}{\bisu@set@chapter@names}
\newcommand\bisu@set@names{%
  \ifbisu@language@chinese
    \ctexset{
      figurename = 图,
      tablename  = 表,
    }%
    \def\bisu@algorithm@name{算法}%
    \def\bisu@equation@name{公式}%
    \def\bisu@assumption@name{假设}%
    \def\bisu@definition@name{定义}%
    \def\bisu@proposition@name{命题}%
    \def\bisu@lemma@name{引理}%
    \def\bisu@theorem@name{定理}%
    \def\bisu@axiom@name{公理}%
    \def\bisu@corollary@name{推论}%
    \def\bisu@exercise@name{练习}%
    \def\bisu@example@name{例}%
    \def\bisu@remark@name{注释}%
    \def\bisu@problem@name{问题}%
    \def\bisu@conjecture@name{猜想}%
    \def\bisu@proof@name{证明}%
    \def\bisu@theorem@separator{：}%
  \else
    \ifbisu@language@english
      \ctexset{
        figurename = {Figure},
        tablename  = {Table},
      }%
      \def\bisu@algorithm@name{Algorithm}%
      \def\bisu@equation@name{Equation}%
      \def\bisu@assumption@name{Assumption}%
      \def\bisu@definition@name{Definition}%
      \def\bisu@proposition@name{Proposition}%
      \def\bisu@lemma@name{Lemma}%
      \def\bisu@theorem@name{Theorem}%
      \def\bisu@axiom@name{Axiom}%
      \def\bisu@corollary@name{Corollary}%
      \def\bisu@exercise@name{Exercise}%
      \def\bisu@example@name{Example}%
      \def\bisu@remark@name{Remark}%
      \def\bisu@problem@name{Problem}%
      \def\bisu@conjecture@name{Conjecture}%
      \def\bisu@proof@name{Proof}%
      \def\bisu@theorem@separator{: }%
    \fi
  \fi
}
\bisu@set@names
\bisu@option@hook{language}{\bisu@set@names}
\xeCJKDeclareCharClass{CJK}{"2460 -> "2473}
\xeCJKDeclareCharClass{CJK}{"2605}
\newcommand\bisu@set@punctuations{%
  \ifbisu@language@chinese
    \xeCJKDeclareCharClass{FullLeft}{"2018, "201C}%
    \xeCJKDeclareCharClass{FullRight}{
      "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
    }%
  \else
    \ifbisu@language@english
      \xeCJKDeclareCharClass{HalfLeft}{"2018, "201C}%
      \xeCJKDeclareCharClass{HalfRight}{
        "00B7, "2019, "201D, "2013, "2014, "2025, "2026, "2E3A,
      }%
    \fi
  \fi
}
\bisu@set@punctuations
\bisu@option@hook{language}{\bisu@set@punctuations}
\renewcommand\normalsize{%
  \@setfontsize\normalsize{12bp}{20bp}%
  \abovedisplayskip 6bp%
  \abovedisplayshortskip 6bp%
  \belowdisplayshortskip 6bp%
  \belowdisplayskip \abovedisplayskip
}
\normalsize
\ifx\MakeRobust\@undefined \else
    \MakeRobust\normalsize
\fi
\def\bisu@def@fontsize#1#2{%
  \expandafter\newcommand\csname #1\endcsname[1][1.3]{%
    \fontsize{#2}{##1\dimexpr #2}\selectfont}}
\bisu@def@fontsize{chuhao}{42bp}
\bisu@def@fontsize{xiaochu}{36bp}
\bisu@def@fontsize{yihao}{26bp}
\bisu@def@fontsize{xiaoyi}{24bp}
\bisu@def@fontsize{erhao}{22bp}
\bisu@def@fontsize{xiaoer}{18bp}
\bisu@def@fontsize{sanhao}{16bp}
\bisu@def@fontsize{xiaosan}{15bp}
\bisu@def@fontsize{sihao}{14bp}
\bisu@def@fontsize{xiaosi}{12bp}
\bisu@def@fontsize{wuhao}{10.5bp}
\bisu@def@fontsize{xiaowu}{9bp}
\bisu@def@fontsize{liuhao}{7.5bp}
\bisu@def@fontsize{xiaoliu}{6.5bp}
\bisu@def@fontsize{qihao}{5.5bp}
\bisu@def@fontsize{bahao}{5bp}
\ifbisu@system@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \bisusetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \bisusetup{system = windows}
      }{
        \bisusetup{system = unix}
      }
    }{
      \bisusetup{system = windows}
    }
  }
\fi
\ifbisu@fontset@auto
  \ifbisu@system@windows
    \bisusetup{fontset = windows}
  \else
    \IfFontExistsTF{SimSun}{
      \bisusetup{fontset = windows}
    }{
      \ifbisu@system@mac
        \bisusetup{fontset = mac}
      \else
        \IfFontExistsTF{Noto Serif CJK SC}{
          \bisusetup{fontset = ubuntu}
        }{
          \bisusetup{fontset = fandol}
        }
      \fi
    }
  \fi
\fi
\ifbisu@font@auto
  \ifbisu@fontset@windows
    \bisusetup{font=times}
  \else
    \ifbisu@fontset@mac
      \bisusetup{font=times}
    \else
      \bisusetup{font=termes}
    \fi
  \fi
\fi
\newcommand\bisu@set@font@times{%
  \setmainfont{Times New Roman}%
  \setsansfont{Arial}%
  \ifbisu@system@mac
    \setmonofont{Menlo}[Scale = MatchLowercase]%
  \else
    \setmonofont{Courier New}[Scale = MatchLowercase]%
  \fi
}
\newcommand\bisu@set@font@termes{%
  \setmainfont{texgyretermes}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \bisu@set@texgyre@sans@mono
}
\newcommand\bisu@set@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Scale          = MatchLowercase,
    Ligatures      = CommonOff,
  ]%
}
\let\bisu@font@family@stix\@empty
\newcommand\bisu@set@stix@names{%
  \ifx\bisu@font@family@stix\@empty
    \IfFontExistsTF{STIXTwoText-Regular.otf}{%
      \gdef\bisu@font@family@stix{STIXTwoText}%
      \gdef\bisu@font@name@stix@math{STIXTwoMath-Regular}%
    }{%
      \gdef\bisu@font@family@stix{STIX2Text}%
      \gdef\bisu@font@name@stix@math{STIX2Math}%
    }%
  \fi
}
\newcommand\bisu@set@font@stix{%
  \bisu@set@stix@names
  \setmainfont{\bisu@font@family@stix}[
    Extension      = .otf,
    UprightFont    = *-Regular,
    BoldFont       = *-Bold,
    ItalicFont     = *-Italic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \bisu@set@texgyre@sans@mono
}
\let\bisu@font@family@xits\@empty
\newcommand\bisu@set@xits@names{%
  \ifx\bisu@font@family@xits\@empty
    \IfFontExistsTF{XITSMath-Regular.otf}{%
      \gdef\bisu@font@family@xits{XITS}%
      \gdef\bisu@font@style@xits@rm{Regular}%
      \gdef\bisu@font@style@xits@bf{Bold}%
      \gdef\bisu@font@style@xits@it{Italic}%
      \gdef\bisu@font@style@xits@bfit{BoldItalic}%
      \gdef\bisu@font@name@xits@math{XITSMath-Regular}%
    }{%
      \gdef\bisu@font@family@xits{xits}%
      \gdef\bisu@font@style@xits@rm{regular}%
      \gdef\bisu@font@style@xits@bf{bold}%
      \gdef\bisu@font@style@xits@it{italic}%
      \gdef\bisu@font@style@xits@bfit{bolditalic}%
      \gdef\bisu@font@name@xits@math{xits-math}%
    }%
  \fi
}
\newcommand\bisu@set@font@xits{%
  \bisu@set@xits@names
  \setmainfont{\bisu@font@family@xits}[
    Extension      = .otf,
    UprightFont    = *-\bisu@font@style@xits@rm,
    BoldFont       = *-\bisu@font@style@xits@bf,
    ItalicFont     = *-\bisu@font@style@xits@it,
    BoldItalicFont = *-\bisu@font@style@xits@bfit,
  ]%
  \bisu@set@texgyre@sans@mono
}
\let\bisu@font@family@libertinus\@empty
\newcommand\bisu@set@libertinus@names{%
  \ifx\bisu@font@family@libertinus\@empty
    \IfFontExistsTF{LibertinusSerif-Regular.otf}{%
      \gdef\bisu@font@family@libertinus@serif{LibertinusSerif}%
      \gdef\bisu@font@family@libertinus@sans{LibertinusSans}%
      \gdef\bisu@font@name@libertinus@math{LibertinusMath-Regular}%
      \gdef\bisu@font@style@libertinus@rm{Regular}%
      \gdef\bisu@font@style@libertinus@bf{Bold}%
      \gdef\bisu@font@style@libertinus@it{Italic}%
      \gdef\bisu@font@style@libertinus@bfit{BoldItalic}%
    }{%
      \gdef\bisu@font@family@libertinus@serif{libertinusserif}%
      \gdef\bisu@font@family@libertinus@sans{libertinussans}%
      \gdef\bisu@font@name@libertinus@math{libertinusmath-regular}%
      \gdef\bisu@font@style@libertinus@rm{regular}%
      \gdef\bisu@font@style@libertinus@bf{bold}%
      \gdef\bisu@font@style@libertinus@it{italic}%
      \gdef\bisu@font@style@libertinus@bfit{bolditalic}%
    }%
  \fi
}
\newcommand\bisu@set@font@libertinus{%
  \bisu@set@libertinus@names
  \setmainfont{\bisu@font@family@libertinus@serif}[
    Extension      = .otf,
    UprightFont    = *-\bisu@font@style@libertinus@rm,
    BoldFont       = *-\bisu@font@style@libertinus@bf,
    ItalicFont     = *-\bisu@font@style@libertinus@it,
    BoldItalicFont = *-\bisu@font@style@libertinus@bfit,
  ]%
  \setsansfont{\bisu@font@family@libertinus@sans}[
    Extension      = .otf,
    UprightFont    = *-\bisu@font@style@libertinus@rm,
    BoldFont       = *-\bisu@font@style@libertinus@bf,
    ItalicFont     = *-\bisu@font@style@libertinus@it,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\bisu@set@font@newcm{%
  \setmainfont{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setsansfont{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmonofont{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}
\newcommand\bisu@set@font@lm{%
  \setmainfont{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setsansfont{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmonofont{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\bisu@set@font@newtx{%
  \RequirePackage{newtxtext}%
}
\newcommand\bisu@set@font{%
  \@nameuse{bisu@set@font@\bisu@font}%
}
\bisu@set@font
\bisu@option@hook{font}{\bisu@set@font}
\ifbisu@cjk@font@auto
  \ifbisu@fontset@mac
    \bisusetup{cjk-font = mac}
  \else
    \ifbisu@fontset@windows
      \bisusetup{cjk-font = windows}
    \else
      \ifbisu@fontset@ubuntu
        \bisusetup{cjk-font = noto}
      \else
        \bisusetup{cjk-font = fandol}
      \fi
    \fi
  \fi
\fi
\newcommand\bisu@set@cjk@font@windows{%
  \xeCJKsetup{EmboldenFactor=3}%
  \setCJKmainfont{SimSun}[
    AutoFakeBold = true,
    ItalicFont   = KaiTi,
  ]%
  \setCJKsansfont{SimHei}[AutoFakeBold]%
  \setCJKmonofont{FangSong}%
  \setCJKfamilyfont{zhsong}{SimSun}[AutoFakeBold]%
  \setCJKfamilyfont{zhhei}{SimHei}[AutoFakeBold]%
  \setCJKfamilyfont{zhkai}{KaiTi}%
  \setCJKfamilyfont{zhfs}{FangSong}%
}
\newcommand\bisu@set@cjk@font@mac{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = Kaiti SC Regular,
    BoldItalicFont = Kaiti SC Bold,
  ]%
  \setCJKsansfont{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKmonofont{STFangsong}
  \setCJKfamilyfont{zhsong}{Songti SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhhei}{Heiti SC}[
    UprightFont    = * Light,
    BoldFont       = * Medium,
  ]%
  \setCJKfamilyfont{zhfs}{STFangsong}%
  \setCJKfamilyfont{zhkai}{Kaiti SC}[
    UprightFont    = * Regular,
    BoldFont       = * Bold,
  ]%
  \setCJKfamilyfont{zhli}{Baoli SC}%
  \setCJKfamilyfont{zhyuan}{Yuanyi SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
  ]%
}
\newcommand\bisu@set@cjk@font@noto{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{Noto Serif CJK SC}[
    UprightFont    = * Light,
    BoldFont       = * Bold,
    ItalicFont     = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
    Script         = CJK,
  ]%
  \setCJKsansfont{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKmonofont{Noto Sans Mono CJK SC}[
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
    UprightFont    = * Light,
    UprightFont    = * Bold,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
    BoldFont       = * Medium,
    Script         = CJK,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension      = .otf,
    UprightFont    = *-Regular,
  ]%
}
\newcommand\bisu@set@cjk@font@fandol{%
  \defaultCJKfontfeatures{}%
  \setCJKmainfont{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
    ItalicFont  = FandolKai-Regular,
    ItalicFeatures = {Extension = .otf},
  ]%
  \setCJKsansfont{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKmonofont{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhsong}{FandolSong}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhhei}{FandolHei}[
    Extension   = .otf,
    UprightFont = *-Regular,
    BoldFont    = *-Bold,
  ]%
  \setCJKfamilyfont{zhfs}{FandolFang}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
  \setCJKfamilyfont{zhkai}{FandolKai}[
    Extension   = .otf,
    UprightFont = *-Regular,
  ]%
}
\ifbisu@cjk@font@none\else
  \providecommand\songti{\CJKfamily{zhsong}}
  \providecommand\heiti{\CJKfamily{zhhei}}
  \providecommand\fangsong{\CJKfamily{zhfs}}
  \providecommand\kaishu{\CJKfamily{zhkai}}
\fi
\newcommand\bisu@set@cjk@font{%
  \@nameuse{bisu@set@cjk@font@\bisu@cjk@font}%
}
\bisu@set@cjk@font
\bisu@option@hook{cjk-font}{\bisu@set@cjk@font}
\newcommand\bisu@set@math@style{%
  \ifbisu@math@style@TeX
    \bisusetup{
      uppercase-greek    = upright,
      less-than-or-equal = horizontal,
      integral           = slanted,
      integral-limits    = false,
      partial            = italic,
      math-ellipsis      = AMS,
      real-part          = fraktur,
    }%
  \else
    \bisusetup{
      uppercase-greek = italic,
      integral        = upright,
      integral-limits = true,
      partial         = upright,
      real-part       = roman,
    }%
    \ifbisu@math@style@ISO
      \bisusetup{
        less-than-or-equal = horizontal,
        math-ellipsis      = lower,
      }%
    \else
      \ifbisu@math@style@GB
        \bisusetup{
          less-than-or-equal = slanted,
          math-ellipsis      = centered,
        }%
      \fi
    \fi
  \fi
}
\ifbisu@main@language@chinese
  \bisusetup{math-style=GB}%
\else
  \bisusetup{math-style=TeX}%
\fi
\bisu@set@math@style
\bisu@option@hook{math-style}{\bisu@set@math@style}
\bisu@option@hook{main-language}{%
  \ifbisu@main@language@chinese
    \bisusetup{math-style=GB}%
  \else
    \bisusetup{math-style=TeX}%
  \fi
}
\newcommand\bisu@set@unimath@leq{%
  \ifbisu@leq@horizontal
    \ifx\@begindocumenthook\@undefined
      \let\le\bisu@save@leq
      \let\ge\bisu@save@geq
      \let\leq\bisu@save@leq
      \let\geq\bisu@save@geq
    \else
      \AtBeginDocument{%
        \let\le\bisu@save@leq
        \let\ge\bisu@save@geq
        \let\leq\bisu@save@leq
        \let\geq\bisu@save@geq
      }%
    \fi
  \else
    \ifbisu@leq@slanted
      \ifx\@begindocumenthook\@undefined
        \let\le\leqslant
        \let\ge\geqslant
        \let\leq\leqslant
        \let\geq\geqslant
      \else
        \AtBeginDocument{%
          \let\le\leqslant
          \let\ge\geqslant
          \let\leq\leqslant
          \let\geq\geqslant
        }%
      \fi
    \fi
  \fi
}
\newcommand\bisu@set@unimath@integral@limits{%
  \ifbisu@integral@limits@true
    \removenolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \else
    \addnolimits{%
      \int\iint\iiint\iiiint\oint\oiint\oiiint
      \intclockwise\varointclockwise\ointctrclockwise\sumint
      \intbar\intBar\fint\cirfnint\awint\rppolint
      \scpolint\npolint\pointint\sqint\intlarhk\intx
      \intcap\intcup\upint\lowint
    }%
  \fi
}
\newcommand\bisu@set@unimath@ellipsis{%
  \ifbisu@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodecdots}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\unicodeellipsis}}%
  \fi
}
\newcommand\bisu@set@unimath@real@part{%
  \ifbisu@real@part@roman
    \AtBeginDocument{%
      \def\Re{\operatorname{Re}}%
      \def\Im{\operatorname{Im}}%
    }%
  \else
    \AtBeginDocument{%
      \let\Re\bisu@save@Re
      \let\Im\bisu@save@Im
    }%
  \fi
}
\newcommand\bisu@set@unimath@style{%
  \ifbisu@uppercase@greek@upright
    \unimathsetup{math-style = TeX}%
  \else
    \ifbisu@uppercase@greek@italic
      \unimathsetup{math-style = ISO}%
    \fi
  \fi
  \ifbisu@math@style@TeX
    \unimathsetup{bold-style = TeX}%
  \else
    \unimathsetup{bold-style = ISO}%
  \fi
  \bisu@set@unimath@leq
  \bisu@set@unimath@integral@limits
  \ifbisu@partial@upright
    \unimathsetup{partial = upright}%
  \else
    \ifbisu@partial@italic
      \unimathsetup{partial = italic}%
    \fi
  \fi
  \bisu@set@unimath@ellipsis
  \bisu@set@unimath@real@part
}
\newcommand\bisu@qed{\rule{1ex}{1ex}}
\newcommand\bisu@load@unimath{%
  \@ifpackageloaded{unicode-math}{}{%
    \RequirePackage{unicode-math}%
    \AtBeginDocument{%
      \let\bisu@save@leq\leq
      \let\bisu@save@geq\geq
      \let\bisu@save@Re\Re
      \let\bisu@save@Im\Im
    }%
    \DeclareRobustCommand\bm[1]{{\symbfit{##1}}}%
    \DeclareRobustCommand\boldsymbol[1]{{\symbfit{##1}}}%
    \newcommand\square{\mdlgwhtsquare}%
    \newcommand\blacksquare{\mdlgblksquare}%
    \AtBeginDocument{%
      \renewcommand\checkmark{\ensuremath{✓}}%
    }%
    \renewcommand\bisu@qed{\ensuremath{\QED}}%
  }%
}
\newcommand\bisu@set@math@font@stix{%
  \bisu@set@stix@names
  \setmathfont{\bisu@font@name@stix@math}[
    Extension    = .otf,
    StylisticSet = \bisu@xits@integral@stylistic@set,
  ]%
  \setmathfont{\bisu@font@name@stix@math}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
}
\newcommand\bisu@xits@integral@stylistic@set{%
  \ifbisu@integral@upright
    8%
  \fi
}
\newcommand\bisu@set@math@font@xits{%
  \bisu@set@xits@names
  \setmathfont{\bisu@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = \bisu@xits@integral@stylistic@set,
  ]%
  \setmathfont{\bisu@font@name@xits@math}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {cal,bfcal},
  ]%
}
\newcommand\bisu@libertinus@integral@stylistic@set{%
  \ifbisu@integral@slanted
    8%
  \fi
}
\newcommand\bisu@set@math@font@libertinus{%
  \bisu@set@libertinus@names
  \setmathfont{\bisu@font@name@libertinus@math}[
    Extension    = .otf,
    StylisticSet = \bisu@libertinus@integral@stylistic@set,
  ]%
}
\newcommand\bisu@newcm@integral@stylistic@set{%
  \ifbisu@integral@upright
    2%
  \fi
}
\newcommand\bisu@set@math@font@newcm{%
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = \bisu@newcm@integral@stylistic@set,
  ]%
  \setmathfont{NewCMMath-Book}[
    Extension    = .otf,
    StylisticSet = 1,
    range        = {scr,bfscr},
  ]%
  \setmathrm{NewCM10}[
    Extension      = .otf,
    UprightFont    = *-Book,
    BoldFont       = *-Bold,
    ItalicFont     = *-BookItalic,
    BoldItalicFont = *-BoldItalic,
  ]%
  \setmathsf{NewCMSans10}[
    Extension         = .otf,
    UprightFont       = *-Book,
    BoldFont          = *-Bold,
    ItalicFont        = *-BookOblique,
    BoldItalicFont    = *-BoldOblique,
  ]%
  \setmathtt{NewCMMono10}[
    Extension           = .otf,
    UprightFont         = *-Book,
    ItalicFont          = *-BookItalic,
    BoldFont            = *-Bold,
    BoldItalicFont      = *-BoldOblique,
  ]%
}
\newcommand\bisu@set@math@font@lm{%
  \setmathfont{latinmodern-math}[Extension=.otf]%
  \setmathrm{lmroman10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmathsf{lmsans10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
  \setmathtt{lmmonolt10}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-oblique,
    BoldItalicFont = *-boldoblique,
  ]%
}
\newcommand\bisu@set@math@font@newtx{%
  \ifbisu@font@newtx\else
    \let\bisu@save@encodingdefault\encodingdefault
    \let\bisu@save@rmdefault\rmdefault
    \let\bisu@save@sfdefault\sfdefault
    \let\bisu@save@ttdefault\ttdefault
    \RequirePackage[T1]{fontenc}%
    \renewcommand{\rmdefault}{ntxtlf}%
    \renewcommand{\sfdefault}{qhv}%
    \renewcommand{\ttdefault}{ntxtt}%
  \fi
  \ifbisu@uppercase@greek@italic
    \PassOptionsToPackage{slantedGreek}{newtxmath}%
  \fi
  \ifbisu@integral@upright
    \PassOptionsToPackage{upint}{newtxmath}%
  \fi
  \RequirePackage{newtxmath}
  \let\bisu@save@leq\leq
  \let\bisu@save@geq\geq
  \ifbisu@leq@slanted
    \let\le\leqslant
    \let\ge\geqslant
    \let\leq\leqslant
    \let\geq\geqslant
  \fi
  \ifbisu@integral@limits@true
    \let\ilimits@\displaylimits
  \fi
  \let\bisu@save@partial\partial
  \ifbisu@partial@upright
    \let\partial\uppartial
  \fi
  \ifbisu@math@ellipsis@centered
    \DeclareRobustCommand\mathellipsis{\mathinner{\cdotp\cdotp\cdotp}}%
  \else
    \DeclareRobustCommand\mathellipsis{\mathinner{\ldotp\ldotp\ldotp}}%
  \fi
  \let\bisu@save@Re\Re
  \let\bisu@save@Im\Im
  \ifbisu@real@part@roman
    \def\Re{\operatorname{Re}}%
    \def\Im{\operatorname{Im}}%
  \fi
  \RequirePackage{bm}%
  \ifbisu@font@newtx\else
    \let\encodingdefault\bisu@save@encodingdefault
    \let\rmdefault\bisu@save@rmdefault
    \let\sfdefault\bisu@save@sfdefault
    \let\ttdefault\bisu@save@ttdefault
  \fi
  \DeclareRobustCommand\symup[1]{{\mathrm{##1}}}%
  \DeclareRobustCommand\symbf[1]{{\bm{##1}}}%
  \let\increment\upDelta%
  \renewcommand\bisu@qed{\openbox}%
}
\newcommand\bisu@set@math@font{%
  \ifbisu@math@font@none\else
    \ifbisu@math@font@newtx
      \bisu@set@math@font@newtx
    \else
      \bisu@load@unimath
      \bisu@set@unimath@style
      \@nameuse{bisu@set@math@font@\bisu@math@font}%
    \fi
  \fi
}
\bisu@option@hook{math-font}{\g@addto@macro\bisu@setup@hook{\bisu@set@math@font}}
\newcommand\bisu@set@math@font@auto{%
  \ifbisu@math@font@auto
    \bisusetup{math-font=xits}%
  \fi
}
\AtBeginOfPackageFile*{siunitx}{\bisu@set@math@font@auto}
\AtEndPreamble{\bisu@set@math@font@auto}
\def\cleardoublepage{%
  \clearpage
  \if@twoside
    \ifbisu@output@print
      \ifodd\c@page
      \else
        \thispagestyle{empty}%
        \hbox{}%
        \newpage
        \if@twocolumn
          \hbox{}\newpage
        \fi
      \fi
    \fi
  \fi
}
\renewcommand\frontmatter{%
  \cleardoublepage
  \@mainmatterfalse
  \pagenumbering{Roman}%
}
\renewcommand\mainmatter{%
  \cleardoublepage
  \@mainmattertrue
  \pagenumbering{arabic}%
}
\renewcommand\backmatter{%
  \if@openright
    \cleardoublepage
  \else
    \clearpage
  \fi
  \@mainmatterfalse
  \bisusetup{toc-depth = 0}%
}
\pagestyle{fancy}
\fancypagestyle{plain}{%
  \fancyhf{}%
  \renewcommand\footrulewidth{0pt}%
  \ifbisu@degree@bachelor
    \renewcommand\headrulewidth{0pt}%
    \fancyfoot[C]{
      \ifbisu@main@language@chinese
        \xiaowu
      \else
        \normalsize
      \fi
      \thepage
    }%
    \let\@mkboth\@gobbletwo
    \let\chaptermark\@gobble
  \else
    \renewcommand\headrulewidth{0.75bp}%
    \fancyhead[C]{%
      \wuhao
      \ifbisu@main@language@chinese
        \leftmark
      \else
        \MakeUppercase{\leftmark}%
      \fi
      }%
    \fancyfoot[C]{\wuhao\thepage}%
    \let\@mkboth\markboth
    \def\chaptermark##1{%
      \markboth{%
        \CTEXifname{%
          \CTEXthechapter
          \ifbisu@main@language@chinese
            \quad
          \else
            \space
          \fi
        }{}##1%
      }{}%
    }%
  \fi
  \let\sectionmark\@gobble
}
\pagestyle{plain}
\def\ps@chapter{}
\ctexset{chapter/pagestyle = chapter}
\ctexset{%
  punct=quanjiao,
  space=auto,
}
\newcommand\bisu@set@indent{%
  \ifbisu@main@language@chinese
    \ctexset{autoindent=2}%
  \else
    \ifbisu@degree@bachelor
      \ctexset{autoindent=0.8cm}%
    \else
      \ctexset{autoindent=0.74cm}%
    \fi
  \fi
}
\bisu@set@indent
\bisu@option@hook{degree}{\bisu@set@indent}
\bisu@option@hook{main-language}{\bisu@set@indent}
\urlstyle{same}
\g@addto@macro\UrlBreaks{%
  \do0\do1\do2\do3\do4\do5\do6\do7\do8\do9%
  \do\A\do\B\do\C\do\D\do\E\do\F\do\G\do\H\do\I\do\J\do\K\do\L\do\M
  \do\N\do\O\do\P\do\Q\do\R\do\S\do\T\do\U\do\V\do\W\do\X\do\Y\do\Z
  \do\a\do\b\do\c\do\d\do\e\do\f\do\g\do\h\do\i\do\j\do\k\do\l\do\m
  \do\n\do\o\do\p\do\q\do\r\do\s\do\t\do\u\do\v\do\w\do\x\do\y\do\z
}
\Urlmuskip=0mu plus 0.1mu
\partopsep=\z@skip
\def\@listi{\leftmargin\leftmargini
            \parsep \z@skip
            \topsep \z@skip
            \itemsep\z@skip}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \itemsep   \z@skip}
\def\@listiii{\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep
              \topsep    \z@skip
              \parsep    \z@skip
              \partopsep \z@skip
              \itemsep   \z@skip}
\setlist{nosep}
\newcommand\bisu@circled[1]{%
  \ifnum#1 >10\relax
    \bisu@error{%
      Too many footnotes in this page.
      Keep footnote less than 10%
    }%
  \fi
  {\symbol{\the\numexpr#1+"245F\relax}}%
}
\renewcommand{\thefootnote}{\bisu@circled{\c@footnote}}
\renewcommand{\thempfootnote}{\bisu@circled{\c@mpfootnote}}
\def\footnoterule{\vskip-3\p@\hrule\@width0.3\textwidth\@height0.4\p@\vskip2.6\p@}
\footnotemargin=13.5bp
\long\def\@makefntext#1{%
  \begingroup
    % 序号取消上标
    \def\@makefnmark{\hbox{\normalfont\@thefnmark}}%
    \xiaowu
    \ifFN@hangfoot
      \bgroup
      \setbox\@tempboxa\hbox{%
        \ifdim\footnotemargin>\z@
          \hb@xt@\footnotemargin{\@makefnmark\hss}%
        \else
          \@makefnmark
        \fi
      }%
      \leftmargin\wd\@tempboxa
      \rightmargin\z@
      \linewidth \columnwidth
      \advance \linewidth -\leftmargin
      \parshape \@ne \leftmargin \linewidth
      % \footnotesize
      \xiaowu
      \@setpar{{\@@par}}%
      \leavevmode
      \llap{\box\@tempboxa}%
      \parskip\hangfootparskip\relax
      \parindent\hangfootparindent\relax
    \else
      \parindent1em%
      \noindent
      \ifdim\footnotemargin>\z@
        \hb@xt@ \footnotemargin{\hss\@makefnmark}%
      \else
        \ifdim\footnotemargin=\z@
          \llap{\@makefnmark}%
        \else
          \llap{\hb@xt@ -\footnotemargin{\@makefnmark\hss}}%
        \fi
      \fi
    \fi
    \footnotelayout#1%
    \ifFN@hangfoot
      \par\egroup
    \fi
  \endgroup
}
\allowdisplaybreaks[4]
\def\fps@figure{h}
\def\fps@table{h}
\setlength{\floatsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\textfloatsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\intextsep}{12\p@ \@plus 2\p@ \@minus 2\p@}
\setlength{\@fptop}{0bp \@plus1.0fil}
\setlength{\@fpsep}{12bp \@plus2.0fil}
\setlength{\@fpbot}{0bp \@plus1.0fil}
\patchcmd{\@addtocurcol}%
  {\vskip \intextsep}%
  {\edef\save@first@penalty{\the\lastpenalty}\unpenalty
   \ifnum \lastpenalty = \@M  % hopefully the OR penalty
     \unpenalty
   \else
     \penalty \save@first@penalty \relax % put it back
   \fi
   \ifnum\outputpenalty <-\@Mii
     \addvspace\intextsep
     \vskip\parskip
   \else
     \addvspace\intextsep
   \fi}%
  {}{\bisu@patch@error{\@addtocurcol}}
\patchcmd{\@addtocurcol}%
  {\vskip\intextsep \ifnum\outputpenalty <-\@Mii \vskip -\parskip\fi}%
  {\ifnum\outputpenalty <-\@Mii
     \aftergroup\vskip\aftergroup\intextsep
     \aftergroup\nointerlineskip
   \else
     \vskip\intextsep
   \fi}%
  {}{\bisu@patch@error{\@addtocurcol}}
\patchcmd{\@getpen}{\@M}{\@Mi}
  {}{\bisu@patch@error{\@getpen}}
\renewcommand{\textfraction}{0.15}
\renewcommand{\topfraction}{0.85}
\renewcommand{\bottomfraction}{0.65}
\renewcommand{\floatpagefraction}{0.60}
\bisu@define@key{
  figure-number-separator = {
    name    = figure@number@separator,
    default = {.},
  },
  table-number-separator = {
    name    = table@number@separator,
    default = {.},
  },
  equation-number-separator = {
    name    = equation@number@separator,
    default = {.},
  },
  number-separator = {
    name    = number@separator,
    default = {.},
  },
}
\renewcommand\thefigure{%
  \ifnum\c@chapter>\z@
    \thechapter
    \bisu@figure@number@separator
  \fi
  \@arabic\c@figure
}
\renewcommand\thetable{%
  \ifnum\c@chapter>\z@
    \thechapter
    \bisu@table@number@separator
  \fi
  \@arabic\c@table
}
\renewcommand\theequation{%
  \ifnum\c@chapter>\z@
    \thechapter
    \bisu@equation@number@separator
  \fi
  \@arabic\c@equation
}
\newcommand\bisu@set@number@separator{%
  \let\bisu@figure@number@separator\bisu@number@separator
  \let\bisu@table@number@separator\bisu@number@separator
  \let\bisu@equation@number@separator\bisu@number@separator
}
\bisu@option@hook{number-separator}{\bisu@set@number@separator}
\DeclareCaptionFont{bisu}{%
  \ifbisu@degree@bachelor
    \fontsize{11bp}{15bp}\selectfont
  \else
    \ifbisu@language@chinese
      \fontsize{11bp}{14.3bp}\selectfont
    \else
      \fontsize{11bp}{12.65bp}\selectfont
    \fi
  \fi
}
\captionsetup{
  font           = bisu,
  labelsep       = quad,
  skip           = 6bp,
  figureposition = bottom,
  tableposition  = top,
}
\captionsetup[sub]{font=bisu}
\renewcommand{\thesubfigure}{(\alph{subfigure})}
\renewcommand{\thesubtable}{(\alph{subtable})}
\newcommand\bisu@set@table@font{
  \ifbisu@language@chinese
    \def\bisu@table@font{%
      \fontsize{11bp}{14.3bp}\selectfont
      \renewcommand\arraystretch{1.42}%
    }%
  \else
    \def\bisu@table@font{%
      \fontsize{11bp}{12.65bp}\selectfont
      \renewcommand\arraystretch{1.47}%
    }%
  \fi
}
\bisu@set@table@font
\bisu@option@hook{language}{\bisu@set@table@font}
\patchcmd\@floatboxreset{%
  \normalsize
}{%
  \bisu@table@font
}{}{\bisu@patch@error{\@floatboxreset}}
\AtEndOfPackageFile*{longtable}{
  \AtBeginEnvironment{longtable}{%
    \bisu@table@font
  }
}
\heavyrulewidth=1.5bp
\lightrulewidth=1bp
\AtEndOfPackageFile*{threeparttable}{
  \g@addto@macro\TPT@defaults{\wuhao}
}
\ifbisu@degree@bachelor
  \newcommand{\bisu@abstract@name}{中文摘要}
  \newcommand{\bisu@abstract@name@en}{ABSTRACT}
\else
%   \newcommand{\bisu@abstract@name}{摘\quad 要}
  \newcommand{\bisu@abstract@name}{内容摘要}
  \newcommand{\bisu@abstract@name@en}{Abstract}
\fi
\ctexset{%
  chapter = {
    nameformat   = {},
    numberformat = {},
    titleformat  = {},
    fixskip      = true,
    aftername    = \quad,
    afterindent  = true,
    lofskip      = 0pt,
    lotskip      = 0pt,
  },
  section = {
    aftername    = \quad,
    afterindent  = true,
  },
  subsection = {
    aftername    = \quad,
    afterindent  = true,
  },
  subsubsection = {
    aftername    = \quad,
    afterindent  = true,
  },
  paragraph/afterindent = true,
  subparagraph/afterindent = true,
}
\newcommand\bisu@set@section@format{%
  \ifbisu@degree@bachelor
    \ctexset{%
      chapter = {
        format     = \centering\sffamily\fontsize{15bp}{20bp}\selectfont,
        beforeskip = 30bp,
        afterskip  = 20bp,
      },
      section = {
        format     = \sffamily\fontsize{14bp}{18bp}\selectfont,
        beforeskip = 25bp,
        afterskip  = 12bp,
      },
      subsection = {
        format     = \sffamily\fontsize{13bp}{15bp}\selectfont,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
      subsubsection = {
        format     = \sffamily\fontsize{12bp}{14bp}\selectfont,
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
    }%
    \ifbisu@main@language@chinese
      \ctexset{
        chapter = {
          name   = {第,章},
          number = \thechapter,
        },
      }%
    \else
      \ctexset{
        chapter = {
          name   = \chaptername\space,
          number = \bisu@english@number{chapter},
        },
      }%
    \fi
  \else
    \ifbisu@main@language@chinese
      \ctexset{%
        chapter = {
          format      = \centering\sffamily\sanhao,
          nameformat  = {},
          titleformat = {},
          name        = {第,章},
        },
        section = {
          format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
        },
        subsection = {
          format     = \sffamily\fontsize{13bp}{20bp}\selectfont,
        },
        subsubsection = {
          format     = \sffamily\fontsize{12bp}{20bp}\selectfont,
        },
      }%
    \else
      \ctexset{%
        chapter = {
          format      = \centering\sffamily\bfseries\fontsize{16bp}{20bp}\selectfont,
          nameformat  = \MakeUppercase,
          titleformat = \MakeUppercase,
          name        = \chaptername\space,
        },
        section = {
          format     = \sffamily\bfseries\fontsize{14bp}{20bp}\selectfont,
        },
        subsection = {
          format     = \sffamily\bfseries\fontsize{13bp}{20bp}\selectfont,
        },
        subsubsection = {
          format     = \sffamily\bfseries\fontsize{12bp}{20bp}\selectfont,
        },
      }%
    \fi
    \ctexset{%
      chapter = {
        beforeskip = 27bp,
        afterskip  = 27bp,
        number     = \thechapter,
      },
      section = {
        beforeskip = 24bp,
        afterskip  = 6bp,
      },
      subsection = {
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
      subsubsection = {
        beforeskip = 12bp,
        afterskip  = 6bp,
      },
    }%
  \fi
}
\bisu@set@section@format
\bisu@option@hook{degree}{\bisu@set@section@format}
\bisu@option@hook{main-language}{\bisu@set@section@format}
\newcommand\bisu@english@number[1]{%
  \expandafter\ifcase\csname c@#1\endcsname
    Zero\or
    One\or
    Two\or
    Three\or
    Four\or
    Five\or
    Six\or
    Seven\or
    Eight\or
    Nine\or
    Ten\or
    Eleven\or
    Twelve\or
    Thirteen\or
    Fourteen\or
    Fifteen\or
    Sixteen\or
    Seventeen\or
    Eighteen\or
    Nineteen\or
    Twenty\or
    \bisu@error{You are genius}%
  \fi
}
\newcommand\bisu@pdfbookmark[2]{}
\newcommand\bisu@phantomsection{}
\NewDocumentCommand\bisu@chapter{s o m o}{%
  \IfBooleanF{#1}{%
    \bisu@error{You have to use the star form: \string\bisu@chapter*}%
  }%
  \if@openright\cleardoublepage\else\clearpage\fi%
  \IfValueTF{#2}{%
    \ifthenelse{\equal{#2}{}}{%
      \bisu@pdfbookmark{0}{#3}%
    }{%
      \bisu@phantomsection
      \addcontentsline{toc}{chapter}{#2}%
    }%
  }{%
    \bisu@phantomsection
    \addcontentsline{toc}{chapter}{#3}%
  }%
  \ifbisu@degree@bachelor\ctexset{chapter/beforeskip=40bp}\fi
  \chapter*{#3}%
  \ifbisu@degree@bachelor\ctexset{chapter/beforeskip=30bp}\fi
  \IfValueTF{#4}{%
    \ifthenelse{\equal{#4}{}}{%
      \@mkboth{}{}%
    }{%
      \@mkboth{#4}{#4}%
    }%
  }{%
    \@mkboth{#3}{#3}%
  }%
}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\renewcommand\tableofcontents{%
  \ifbisu@degree@graduate
    \bisu@chapter*{\contentsname}%
  \else
    \bisu@chapter*[]{\contentsname}%
  \fi
  \@starttoc{toc}%
}
\bisu@define@key{
  toc-chapter-style = {
    name = toc@chapter@style,
    choices = {
      arial,
      times,
    },
    default = arial,
  },
}
\newcommand\bisu@leaders{\titlerule*[4bp]{.}}
\newcommand\bisu@set@toc@format{%
  \contentsmargin{\z@}%
  \ifbisu@degree@bachelor
    \ifbisu@main@language@chinese
      \titlecontents{chapter}
        [\z@]{\addvspace{6bp}
          \ifbisu@toc@chapter@style@arial
            \sffamily
          \else
            \heiti
          \fi
        }
        {\contentspush{\thecontentslabel\quad}}{}
        {\rmfamily\bisu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\bisu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [1.5em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\bisu@leaders\thecontentspage}%
    \else
      \ifbisu@main@language@english
        \titlecontents{chapter}
          [\z@]{\addvspace{6bp}\sffamily}
          {\contentspush{\thecontentslabel\quad}}{}
          {\rmfamily\bisu@leaders\thecontentspage}%
        \titlecontents{section}
          [0.5cm]{}
          {\contentspush{\thecontentslabel\quad}}{}
          {\bisu@leaders\thecontentspage}%
        \titlecontents{subsection}
          [1cm]{}
          {\contentspush{\thecontentslabel\quad}}{}
          {\bisu@leaders\thecontentspage}%
      \fi
    \fi
  \else
    \ifbisu@main@language@chinese
      \titlecontents{chapter}
        [\z@]{\addvspace{6bp}\sffamily}
        {\contentspush{\thecontentslabel\quad}}{}
        {\rmfamily\bisu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\bisu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [2em]{}
        {\contentspush{\thecontentslabel\quad}}{}
        {\bisu@leaders\thecontentspage}%
    \else
      \titlecontents{chapter}
        [\z@]{\addvspace{6bp}\heiti}
        {\contentspush{\MakeUppercase{\thecontentslabel}\quad}\MakeUppercase}{\MakeUppercase}
        {\rmfamily\bisu@leaders\thecontentspage}%
      \titlecontents{section}
        [1em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\bisu@leaders\thecontentspage}%
      \titlecontents{subsection}
        [2em]{}
        {\contentspush{\thecontentslabel\space}}{}
        {\bisu@leaders\thecontentspage}%
    \fi
  \fi
}
\bisu@set@toc@format
\bisu@option@hook{degree}{\bisu@set@toc@format}
\bisu@option@hook{main-language}{\bisu@set@toc@format}
\bisu@define@key{
  secret-level = {
    name = secret@level,
  },
  secret-year = {
    name = secret@year,
  },
  title = {
    default = {标题},
  },
  title* = {
    default = {Title},
    name    = title@en,
  },
  author = {
    default = {姓名},
  },
  author* = {
    default = {Name of author},
    name    = author@en,
  },
  student-id = {
    name = student@id,
  },
  supervisor = {
    default = {导师姓名},
  },
  supervisor* = {
    default = {Name of supervisor},
    name    = supervisor@en,
  },
  associate-supervisor = {
    name = associate@supervisor,
  },
  associate-supervisor* = {
    name = associate@supervisor@en,
  },
  co-supervisor = {
    name = co@supervisor,
  },
  co-supervisor* = {
    name = co@supervisor@en,
  },
  % Reserved for compatibility
  joint-supervisor = {
    name = co@supervisor,
  },
  joint-supervisor* = {
    name = co@supervisor@en,
  },
  degree-name = {
    default = {工学博士},
    name    = degree@name,
  },
  degree-name* = {
    default = {Doctor of Philosophy},
    name    = degree@name@en,
  },
  department = {
    default = {计算机科学与技术系},
  },
  discipline = {
    % default = {计算机科学与技术},
  },
  discipline* = {
    % default = {Computer Science and Technology},
    name    = discipline@en,
  },
  date = {
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  clc,
  udc,
  id,
  discipline-level-1 = {
    default = {一级学科名称},
    name    = discipline@level@i,
  },
  discipline-level-2 = {
    default = {二级学科名称},
    name    = discipline@level@ii,
  },
  start-date = {
    name    = start@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  end-date = {
    name    = end@date,
    default = {\the\year-\two@digits{\month}-\two@digits{\day}},
  },
  include-spine = {
    name = include@spine,
    choices = {
      false,
      true,
    },
    default = false,
  },
}
\newcommand\bisu@format@date[2]{%
  \edef\bisu@@date{#2}%
  \def\bisu@@process@date##1-##2-##3\@nil{%
    #1{##1}{##2}{##3}%
  }%
  \expandafter\bisu@@process@date\bisu@@date\@nil
}
\newcommand\bisu@date@zh@digit[3]{#1 年 \number#2 月 \number#3 日}
\newcommand\bisu@date@zh@digit@short[3]{#1 年 \number#2 月}
\newcommand\bisu@date@zh@short[3]{\zhdigits{#1}年\zhnumber{#2}月}
\newcommand\bisu@date@month[1]{%
  \ifcase\number#1\or
    January\or February\or March\or April\or May\or June\or
    July\or August\or September\or October\or November\or December%
  \fi
}
\newcommand\bisu@date@en@short[3]{\bisu@date@month{#2}, #1}
\newcommand\bisu@underline[2][6em]{\hskip1pt\underline{\hb@xt@ #1{\hss#2\hss}}\hskip3pt}
\newcommand\bisu@CJKunderline[2][6em]{\CJKunderline*{\hb@xt@ #1{\hss#2\hss}}}
\newcommand\bisu@fixed@box[2]{%
  \begingroup
    \def\CJKglue{\hskip 0pt plus 2filll minus 1filll}%
    \makebox[#1][l]{#2}%
  \endgroup
}
\newbox\bisu@stretch@box
\newcommand\bisu@stretch[2]{%
  \sbox\bisu@stretch@box{#2}%
  \ifdim \wd\bisu@stretch@box < #1\relax
    \begingroup
      \def\CJKglue{\hskip 0pt plus 2filll}%
      \makebox[#1][l]{#2}%
    \endgroup
  \else
    \box\bisu@stretch@box
  \fi
}
\newbox\bisu@pad@box
\newcommand\bisu@pad[2]{%
  \sbox\bisu@pad@box{#2}%
  \ifdim \wd\bisu@pad@box < #1\relax
    \makebox[#1][l]{\box\bisu@pad@box}%
  \else
    \box\bisu@pad@box
  \fi
}
\newcounter{bisu@csl@count}
\newcommand\bisu@name@title@process[1]{%
  \ifcase\c@bisu@csl@count  % == 0
    \gdef\bisu@@name{#1}%
  \or  % == 1
    \gdef\bisu@@title{#1}%
  \fi
  \stepcounter{bisu@csl@count}%
}
\newcommand\bisu@name@title@format[2]{%
  \bisu@pad{3cm}{\bisu@stretch{4em}{#1}}%
  \bisu@stretch{3em}{#2}%
}
\newcommand\bisu@name@title[1]{%
  \setcounter{bisu@csl@count}{0}%
  \gdef\bisu@@name{}%
  \gdef\bisu@@title{}%
  \expandafter\comma@parse\expandafter{#1}{\bisu@name@title@process}%
  \bisu@name@title@format{\bisu@@name}{\bisu@@title}%
}
\renewcommand\maketitle{%
  \cleardoublepage
  \pagenumbering{Alph}%
  \bisu@pdfbookmark{-1}{\bisu@title}%
  \bisu@titlepage
  \ifbisu@include@spine@true
    \bisu@spine
  \fi
  \ifbisu@degree@graduate
    \ifbisu@thesis@type@thesis
      \cleardoublepage
      \bisu@titlepage@en
    \fi
  \fi
  \clearpage
}
\newcommand\bisu@titlepage{%
  \bisusetup{language = chinese}%
  \ifbisu@degree@graduate
    \ifbisu@thesis@type@thesis
      \ifbisu@degree@type@academic
        \bisu@titlepage@graduate@academic
      \else
        \ifx\bisu@discipline\@empty
          \bisu@titlepage@graduate@professional
        \else
          \bisu@titlepage@graduate@academic
        \fi
      \fi
    \else
      \ifbisu@thesis@type@proposal
        \bisu@titlepage@proposal
      \fi
    \fi
  \else
    \ifbisu@degree@bachelor
      \bisu@titlepage@bachelor
    \else
      \ifbisu@degree@postdoc
        \bisu@cover@postdoc
        \cleardoublepage
        \bisu@titlepage@postdoc
      \fi
    \fi
  \fi
  \bisu@reset@main@language
}
\newcommand\bisu@titlepage@graduate@academic{%
  \newgeometry{
    top     = 2cm,
    bottom  = 6cm,
    hmargin = 3.5cm,
  }%
  \thispagestyle{empty}%
  \null\vskip 8.1pt%
  \begingroup
    \centering
    \parbox[t][2cm][t]{\textwidth}{%
      \hskip -21.5pt%
      \bisu@titlepage@secret
    }\par
    \vskip 40.5pt%
    \begingroup
      \sffamily\fontsize{26bp}{46.8bp}\selectfont
      \bisu@title\par
    \endgroup
    \ifbisu@main@language@english
      \vskip 5.4pt%
      \begingroup
        \sffamily\bfseries\fontsize{20bp}{31.2bp}\selectfont
        \bisu@title@en\par
      \endgroup
      \vskip -9.2pt%
    \fi
    \vskip 24.1pt%
    \bisu@titlepage@degree
    \vfill
    \parbox[t][7.25cm][t]{\textwidth}{%
      \centering\fangsong\fontsize{16bp}{31.2bp}\selectfont
      \bisu@titlepage@info
    }\par
    \parbox[t][1.03cm][t]{\textwidth}{\centering\bisu@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\bisu@titlepage@graduate@professional{%
  \newgeometry{
    top     = 2cm,
    bottom  = 6cm,
    hmargin = 3.5cm,
  }%
  \thispagestyle{empty}%
  \null\vskip 0.45cm%
  \begingroup
    \centering
    \parbox[t][1.52cm][t]{\textwidth}{%
      \hskip -0.69cm%
      \bisu@titlepage@secret
    }\par
    \vskip 1.5cm%
    \begingroup
      % 1.21 倍行距，无网格
      \sffamily\fontsize{26bp}{40.9bp}\selectfont
      \bisu@title\par
    \endgroup
    \ifbisu@main@language@english
      \vskip 5.4pt%
      \begingroup
        \sffamily\bfseries\fontsize{20bp}{31.2bp}\selectfont
        \bisu@title@en\par
      \endgroup
      \vskip -9.2pt%
    \fi
    \vskip 25.5pt%
    \bisu@titlepage@degree
    \vfill
    \parbox[t][5.24cm][t]{\textwidth}{%
      \centering\fangsong\fontsize{16bp}{1cm}\selectfont
      \bisu@titlepage@info
    }\par
    \parbox[t][1.25cm][t]{\textwidth}{\centering\bisu@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\bisu@titlepage@proposal{%
  \newgeometry{
    top     = 5cm,
    bottom  = 3.25cm,
    hmargin = 3.17cm,
  }%
  \thispagestyle{empty}%
  \begingroup
    % \vspace*{0.1cm}%
    \centering
    % {\bisu@titlepage@title}%
    \parbox[t][3cm]{\textwidth}{%
      \vskip 0.1cm%
      \centering
      \sffamily\fontsize{26bp}{46.8bp}\selectfont
      \bisu@title\par
    }%
    \vskip 0.85cm%
    \bisu@titlepage@degree
    \vfill
    \parbox[t][8.5cm][t]{\textwidth}{%
      \centering\CJKfamily+{}%
      \centering\fangsong\sanhao[1.95]%
      \bisu@titlepage@info
    }\par
    \parbox[t][2.5cm][t]{\textwidth}{\centering\bisu@titlepage@date}\par
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\bisu@set@student@id{%
  \ifbisu@thesis@type@proposal
    \ifx\bisu@student@id\@empty
      \bisusetup{student-id=2000310000}%
    \fi
  \fi
}
\bisu@set@student@id
\bisu@option@hook{thesis-type}{\bisu@set@student@id}
\newcommand\bisu@titlepage@secret{%
  \sffamily\sanhao
  \ifx\bisu@secret@level\@empty
    \phantom{秘密}%
  \else
    \bisu@secret@level★\makebox[3em][c]{\bisu@secret@year}年%
  \fi\par
}
\newcommand\bisu@titlepage@degree{%
  \begingroup
    \CJKfamily+{}\xiaoer
    \def\CJKglue{\hskip 1bp}%
    \ifbisu@thesis@type@thesis
      (申请北京第二外国语学院\bisu@degree@name
      \ifbisu@degree@type@professional
        专业%
      \fi
      学位论文)%
    \else
      \ifbisu@thesis@type@proposal
        (北京第二外国语学院%
        \ifbisu@degree@doctor
          博士%
        \else
          \ifbisu@degree@master
            硕士%
          \fi
        \fi
        学位论文选题报告)%
      \fi
    \fi
    \par
  \endgroup
}
\newcommand\bisu@titlepage@info{%
  \ifbisu@degree@doctor
    \ifbisu@degree@type@academic
      \bisu@titlepage@info@doctor@academic
    \else
      \bisu@titlepage@info@doctor@professional
    \fi
  \else
    \ifbisu@degree@type@academic
      \bisu@titlepage@info@master@academic
    \else
      \ifx\bisu@discipline\@empty
        \bisu@titlepage@info@master@other
      \else
        \bisu@titlepage@info@master@engineer
      \fi
    \fi
  \fi
}
\newcommand\bisu@titlepage@info@tabular[4]{%
  \def\bisu@info@item##1##2##3{%
    \ifx##3\@empty\else
      \bisu@pad{#1}{\bisu@fixed@box{#2}{##1}}%
      \bisu@pad{#3}{：}%
      ##2{##3}\\
    \fi
  }%
  \begin{tabular}{l}%
    \renewcommand\arraystretch{1}%
    #4%
  \end{tabular}%
}
\newcommand\bisu@titlepage@info@doctor@academic{%
  \bisu@titlepage@info@tabular{2.8cm}{2.8cm}{0.82cm}{%
    \bisu@info@item{培养单位}{}{\bisu@department}%
    \bisu@info@item{学科}{}{\bisu@discipline}%
    \bisu@info@item{研究生}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{学号}{}{\bisu@student@id}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{副指导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合导师}{\bisu@name@title}{\bisu@co@supervisor}%
  }\par
}
\newcommand\bisu@titlepage@info@doctor@professional{%
  \bisu@titlepage@info@tabular{3.03cm}{5em}{1.52cm}{%
    \bisu@info@item{培养单位}{}{\bisu@department}%
    \bisu@info@item{申请人}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{学号}{}{\bisu@student@id}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{副指导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合导师}{\bisu@name@title}{\bisu@co@supervisor}%
  }\par
}
\newcommand\bisu@titlepage@info@master@academic{%
  \bisu@titlepage@info@tabular{3.59cm}{5.5em}{0.82cm}{%
    \bisu@info@item{培养单位}{}{\bisu@department}%
    \bisu@info@item{学科}{}{\bisu@discipline}%
    \bisu@info@item{研究生}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{学号}{}{\bisu@student@id}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{副指导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合指导教师}{\bisu@name@title}{\bisu@co@supervisor}%
  }\par
}
\newcommand\bisu@titlepage@info@master@engineer{%
  \bisu@titlepage@info@tabular{2.8cm}{2.8cm}{1.34cm}{%
    \bisu@info@item{培养单位}{}{\bisu@department}%
    \bisu@info@item{工程领域}{}{\bisu@discipline}%
    \bisu@info@item{申请人}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{学号}{}{\bisu@student@id}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{副指导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合指导教师}{\bisu@name@title}{\bisu@co@supervisor}%
  }\par
}
\newcommand\bisu@titlepage@info@master@other{%
  \bisu@titlepage@info@tabular{3.28cm}{5em}{1.52cm}{%
    \bisu@info@item{培养单位}{}{\bisu@department}%
    \bisu@info@item{申请人}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{学号}{}{\bisu@student@id}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{副指导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合指导教师}{\bisu@name@title}{\bisu@co@supervisor}%
  }\par
}
\newcommand\bisu@titlepage@date{%
  \begingroup
    \sanhao
    \def\CJKglue{\hskip 1bp}%
    \bisu@format@date{\bisu@date@zh@short}{\bisu@date}\par
  \endgroup
}
\newcommand{\bisu@titlepage@en}{%
  \newgeometry{
    top     = 5.5cm,
    bottom  = 5cm,
    hmargin = 3.6cm,
  }%
  \thispagestyle{empty}%
  \bisusetup{language = english}%
  \ifbisu@degree@type@academic
    \bisu@titlepage@en@graduate@academic
  \else
    \bisu@titlepage@en@graduate@professional
  \fi
  \bisu@reset@main@language
  \clearpage
  \restoregeometry
}
\newcommand\bisu@titlepage@en@graduate@academic{%
  \begingroup
    \centering
    \null\vskip -0.7cm%
    \bisu@titlepage@en@title
    \vfill
    \sanhao[1.725]%
    \bisu@titlepage@en@degree
    \vskip 0.13cm%
    in\par
    \vskip 0.1cm%
    {\bfseries\sffamily\bisu@discipline@en\par}
    \vskip 0.7cm%
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\bisu@author@en\par}%
    \vskip 0.14cm%
    \parbox[t][3.07cm][t]{\textwidth}{%
      \centering\xiaosan[2.1]%
      \bisu@titlepage@en@supervisor
    }\par
    \bisu@titlepage@en@date
    \vskip 0.65cm%
  \endgroup
}
\newcommand\bisu@titlepage@en@graduate@professional{%
  \begingroup
    \centering
    \null\vskip -0.7cm%
    \bisu@titlepage@en@title
    \vfill
    \sanhao[1.725]%
    \bisu@titlepage@en@degree
    \vskip 1.1cm%
    {\sffamily by\par}
    \vskip 0.24cm%
    {\sffamily\bfseries\bisu@author@en\par}%
    \ifx\bisu@discipline@en\empty
      \vskip 1.95cm%
    \else
      \vskip -0.1cm%
      {\sffamily\bfseries(\bisu@discipline@en)\par}%
      \vskip 1.1cm%
    \fi
    \parbox[t][3.37cm][t]{\textwidth}{%
      \centering\xiaosan[1.82]%
      \bisu@titlepage@en@supervisor
    }\par
    \bisu@titlepage@en@date
    \vskip 0.3cm%
  \endgroup
}
\newcommand\bisu@titlepage@en@title{%
  \begingroup
    \sffamily\bfseries\fontsize{20bp}{31bp}\selectfont
    \bisu@title@en\par
  \endgroup
}
\newcommand\bisu@thesis@name@en{%
  \ifbisu@degree@master
    Thesis%
  \else
    Dissertation%
  \fi
}
\newcommand\bisu@titlepage@en@degree{%
  \bisu@thesis@name@en{} Submitted to\par
  {\bfseries BISU University\par}%
  in partial fulfillment of the requirement\par
  for the
  \ifbisu@degree@type@professional
    professional
  \fi
  degree of\par
  {\sffamily\bfseries\bisu@degree@name@en\par}%
}
\newcommand\bisu@titlepage@en@supervisor{%
  \begin{tabular}{r@{\makebox[0.71cm][l]{:}}l}%
    \renewcommand\arraystretch{1}%
    \bisu@thesis@name@en{} Supervisor & \bisu@supervisor@en \\
    \ifx\bisu@associate@supervisor@en\@empty\else
      Associate Supervisor           & \bisu@associate@supervisor@en \\
    \fi
    \ifx\bisu@co@supervisor@en\@empty\else
      Co-supervisor                  & \bisu@co@supervisor@en \\
    \fi
  \end{tabular}%
}
\newcommand\bisu@titlepage@en@date{%
  \begingroup
    \sffamily\bfseries\sanhao
    \bisu@format@date{\bisu@date@en@short}{\bisu@date}\par
  \endgroup
}
\newcommand\bisu@titlepage@bachelor{%
  \newgeometry{
    vmargin = 2.54cm,
    hmargin = 3.17cm,
  }%
  \thispagestyle{empty}%
  \begingroup
    \centering
    \parbox[t][0cm][t]{\textwidth}{%
      \hfill
      \xiaosi
      \ifx\bisu@secret@level\@empty\else
        \bisu@secret@level\space\bisu@secret@year 年\par
      \fi
    }%
  \endgroup
  \vfill
  \begingroup
    \centering
    \includegraphics{bisu-name-bachelor.pdf}%
    \vskip 0.94cm%
    {\sffamily\bfseries\xiaochu\ziju{0.5}综合论文训练\par}%
  \endgroup
  \vskip 1.8cm%
  \begingroup
    \heiti
    \ifbisu@main@language@chinese
      \yihao[1.56]%
    \else
      \fontsize{26bp}{32bp}\selectfont
    \fi
    \parindent=18bp%
    \hangindent=72bp%
    \makebox[54bp]{\xiaoer[1.2]题目：}%
    \CJKunderline*[skip=false, thickness=0.05em, depth=0.12em]{\bisu@title}%
    \ifbisu@main@language@english
      \\
      \bisusetup{language=english}%
      \ul\bisu@title@en
      \bisusetup{language=chinese}%
    \fi
    \par
  \endgroup
  \vskip 1.9cm%
  \begingroup
    \fangsong\sanhao[2.32]%
    \leftskip=2.5cm%
    \parindent=\z@
    \def\bisu@info@item##1##2##3{%
      \ifx##3\@empty\else
        \bisu@fixed@box{%
          \ifx\bisu@co@supervisor\@empty
            4em%
          \else
            5.5em%
          \fi
        }{##1}：##2{##3}\par
      \fi
    }%
    \def\bisu@name@title@format##1##2{%
      \bisu@stretch{3em}{##1}\quad ##2%
    }%
    \bisu@info@item{系别}{}{\bisu@department}%
    \bisu@info@item{专业}{}{\bisu@discipline}%
    \bisu@info@item{姓名}{\bisu@name@title}{\bisu@author}%
    \bisu@info@item{指导教师}{\bisu@name@title}{\bisu@supervisor}%
    \bisu@info@item{辅导教师}{\bisu@name@title}{\bisu@associate@supervisor}%
    \bisu@info@item{联合指导教师}{\bisu@name@title}{\bisu@co@supervisor}%
  \endgroup
  \vskip 1.4cm%
  \begingroup
    \centering
    {\CJKfamily+{}\xiaosi\bisu@format@date{\bisu@date@zh@digit}{\bisu@date}\par}%
  \endgroup
  \vfill
  \clearpage
  \restoregeometry
}
\newcommand\bisu@cover@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \renewcommand\ULthickness{0.7pt}%
    \vspace*{0.35cm}%
    {\sihao[2.6]%
      \bisu@stretch{3.1em}{分类号}\bisu@underline[3.7cm]{\bisu@clc}\hfill
      密级\bisu@underline[3.7cm]{\bisu@secret@level}\par
      \bisu@stretch{3.1em}{U D C}\bisu@underline[3.7cm]{\bisu@udc}\hfill
      编号\bisu@underline[3.7cm]{\bisu@id}\par
    }%
    \vskip 3.15cm%
    {\sffamily\bfseries\xiaoer[2.6]%
      {\ziju{1.5}北京第二外国语学院\par}%
      {\ziju{0.5}博士后研究工作报告\par}%
    }%
    \vskip 0.2cm%
    \parbox[t][4.0cm][c]{\textwidth}{%
      \centering\sihao[3.46]\CJKunderline*[depth=1em]{\bisu@title}\par
    }\par
    \vskip 0.4cm%
    {\xiaosi\bisu@author\par}%
    \vskip 1.4cm%
    {\xiaosi[1.58]\xeCJKsetup{underline/depth=0.9em}%
      工作完成日期\quad
      \bisu@CJKunderline[5.9cm]{%
        \bisu@format@date{\bisu@date@zh@digit@short}{\bisu@start@date}—%
        \bisu@format@date{\bisu@date@zh@digit@short}{\bisu@end@date}
      }\par
      \vskip 0.55cm%
      报告提交日期\quad
      \bisu@CJKunderline[5.9cm]{\bisu@format@date{\bisu@date@zh@digit@short}{\bisu@date}}\par
    }%
    \vskip 0.45cm%
    {\xiaosi[2]{\ziju{1}北京第二外国语学院}\quad （北京）\par}%
    \vskip 0.25cm%
    {\xiaosi[2]\bisu@format@date{\bisu@date@zh@digit@short}{\bisu@date}\par}%
  \end{center}%
}
\newcommand\bisu@titlepage@postdoc{%
  \thispagestyle{empty}%
  \begin{center}%
    \vspace*{1.5cm}%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sanhao[1.95]\bisu@title\par
    }\par
    \vskip 0.15cm%
    \parbox[t][3cm][c]{\textwidth}{%
      \centering\sihao[1.36]\bisu@title@en\par
    }\par
    \vskip 0.4cm%
    {\xiaosi[2.6]%
      \begin{tabular}{l@{\quad}l}%
        \renewcommand\arraystretch{1}%
        \bisu@stretch{11em}{博士后姓名}                  & \bisu@author           \\
        \bisu@stretch{11em}{流动站（一级学科）名称}      & \bisu@discipline@level@i  \\
        \bisu@stretch{11em}{专\quad{}业（二级学科）名称} & \bisu@discipline@level@ii \\
      \end{tabular}\par
    }%
    \vskip 2.7cm%
    {\xiaosi[2.6]%
      研究工作起始时间\quad\bisu@format@date{\bisu@date@zh@digit}{\bisu@start@date}\par
      \vskip 0.1cm%
      研究工作期满时间\quad\bisu@format@date{\bisu@date@zh@digit}{\bisu@end@date}\par
    }%
    \vskip 2.1cm%
    {\xiaosi[2.6]北京第二外国语学院人事处（北京）\par}%
    \vskip 0.6cm%
    {\wuhao\bisu@format@date{\bisu@date@zh@digit@short}{\bisu@date}\par}%
  \end{center}%
}
\def\bisu@committee@name{学位论文指导小组、公开评阅人和答辩委员会名单}
\newenvironment{committee}[1][]{%
  \cleardoublepage
  \let\bisu@committee@file\@empty
  \kv@define@key{bisu@committee}{name}{\let\bisu@committee@name\kv@value}%
  \kv@define@key{bisu@committee}{file}{\let\bisu@committee@file\kv@value}%
  \kv@set@family@handler{bisu@committee}{%
    \ifx\kv@value\relax
      \let\bisu@committee@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{bisu@committee}{#1}%
  \ifx\bisu@committee@file\@empty
    \begingroup
      \ifbisu@main@language@english
        \ctexset{chapter/format=\centering\sffamily\fontsize{16bp}{20bp}\selectfont}
      \fi
      \bisu@chapter*[]{\bisu@committee@name}%
    \endgroup
  \else
    \bisu@pdfbookmark{0}{\bisu@committee@name}%
    \includepdf{\bisu@committee@file}%
  \fi
  \thispagestyle{empty}%
  \ctexset{
    section = {
      format    += {\centering},
      numbering = false,
      afterindent = false,
    },
  }%
  \bisusetup{language=chinese}
}{%
  \bisu@reset@main@language
}
\newcommand\copyrightpage[1][]{%
  \cleardoublepage
  \ifbisu@degree@postdoc\relax\else
    \def\bisu@@tmp{#1}
    \ifx\bisu@@tmp\@empty
      \bisusetup{language=chinese}%
      \ifbisu@degree@bachelor
        \bisu@copyright@page@bachelor
      \else
        \bisu@copyright@page@graduate
      \fi
      \bisu@reset@main@language
    \else
      \thispagestyle{empty}%
      \bisu@pdfbookmark{0}{关于学位论文使用授权的说明}%
      \bisu@phantomsection
      \kv@define@key{bisu@copyright}{file}{\includepdf[pages=-]{\kv@value}}%
      \kv@set@family@handler{bisu@copyright}{%
        \ifx\kv@value\relax
          \includepdf[pages=-]{\kv@key}%
        \else
          \kv@handled@false
        \fi
      }%
      \kvsetkeys{bisu@copyright}{#1}%
    \fi
  \fi
}
\newcommand{\bisu@authorization@frontdate}{%
  日\ifbisu@degree@bachelor\hspace{1em}\else\hspace{2em}\fi 期：}
\newcommand\bisu@copyright@page@graduate{%
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao},
        beforeskip = 40bp,
        afterskip  = 36bp,
      },
    }%
    \bisu@chapter*[]{关于学位论文使用授权的说明}%
    \thispagestyle{empty}%
  \endgroup
  \vskip 13bp%
  \begingroup
    \fontsize{14bp}{26bp}\selectfont
    本人完全了解北京第二外国语学院有关保留、使用学位论文的规定，即：\par
    北京第二外国语学院拥有在著作权法规定范围内学位论文的使用权，其中包括：%
    （1）\nobreak 已获学位的研究生必须按学校规定提交学位论文，%
    学校可以采用影印、缩印或其他复制手段保存研究生上交的学位论文；\allowbreak
    （2）\nobreak 为教学和科研目的，学校可以将公开的学位论文作为资料在图书馆、资料室等场所供校内师生阅读，%
    或在校园网上供校内师生浏览部分内容；\allowbreak
    \ifbisu@degree@doctor
      （3）\nobreak 根据《中华人民共和国学位条例暂行实施办法》及上级教育主管部门具体要求，向国家图书馆报送相应的学位论文。%
    \else
      （3）\nobreak 按照上级教育主管部门督导、抽查等要求，报送相应的学位论文。%
    \fi
    \par
    本人保证遵守上述规定。\par
  \endgroup
  \vskip 33bp%
  \begingroup
    \fontsize{12bp}{23.4bp}\selectfont
    \parindent\z@
    \leftskip 43bp%
    作者签名：\hspace{4bp}\bisu@underline[7em]{}\hspace{47bp}%
    导师签名：\hspace{4bp}\bisu@underline[7em]{}\par
    \vskip 6bp%
    日\hspace{2em}期：\hspace{4bp}\bisu@underline[7em]{}\hspace{47bp}%
    日\hspace{2em}期：\hspace{4bp}\bisu@underline[7em]{}\par
  \endgroup
}
\newcommand\bisu@copyright@page@bachelor{%
  \begingroup
    \ctexset{
      chapter = {
        format     = {\centering\sffamily\erhao[1]},
        beforeskip = 1bp,
        afterskip  = 24bp,
      },
    }%
    \bisu@chapter*[]{关于学位论文使用授权的说明}%
    \thispagestyle{empty}%
  \endgroup
  \vskip 4bp%
  本人完全了解北京第二外国语学院有关保留、使用学位论文的规定，即：%
  学校有权保留学位论文的复印件，允许该论文被查阅和借阅；%
  学校可以公布该论文的全部或部分内容，可以采用影印、缩印或其他复制手段保存该论文。\par
  \textbf{(涉密的学位论文在解密后应遵守此规定)}\par
  \null\par
  \begingroup
    \centering
    签\quad 名：\bisu@underline[6em]{}%
    导师签名：\bisu@underline[6em]{}%
    日\quad 期\bisu@underline[6em]{}%
    \par
  \endgroup
}
\bisu@define@key{
  keywords,
  keywords* = {
    name = keywords@en,
  },
}
\newcommand\bisu@clist@use[2]{%
  \def\bisu@@tmp{}%
  \def\bisu@clist@processor##1{%
    \ifx\bisu@@tmp\@empty
      \def\bisu@@tmp{#2}%
    \else
      #2%
    \fi
    ##1%
  }%
  \expandafter\comma@parse\expandafter{#1}{\bisu@clist@processor}%
}
\newenvironment{abstract}{%
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \bisusetup{language = chinese}%
  \ifbisu@degree@graduate
    \begingroup
      \ifbisu@main@language@english
        \ctexset{%
          chapter/format = \centering\sffamily\fontsize{16bp}{20bp}\selectfont,
        }%
      \fi
      \bisu@chapter*{\bisu@abstract@name}%
    \endgroup
  \else
    \bisu@chapter*[]{\bisu@abstract@name}%
  \fi
}{%
  \par
  \null\par
  \ifbisu@degree@graduate
    \noindent
    \textsf{关键词：}%
  \else
    \textbf{关键词：}%
  \fi
  \bisu@clist@use{\bisu@keywords}{；}%
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \bisu@reset@main@language % switch back to main language
}
\newenvironment{abstract*}{%
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \bisusetup{language = english}%
  \ifbisu@degree@graduate
    \bisu@chapter*{\bisu@abstract@name@en}%
  \else
    \bisu@chapter*[]{\bisu@abstract@name@en}%
  \fi
}{%
  \par
  \null\par
  \ifbisu@degree@graduate
    \noindent
  \fi
  \textbf{Keywords:}\space
  \bisu@clist@use{\bisu@keywords@en}{; }%
  \ifbisu@degree@graduate
    \vspace*{\stretch{1}}%
  \fi
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \bisu@reset@main@language % switch back to main language
}
\newenvironment{denotation}[1][2.5cm]{%
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \ifbisu@degree@graduate
    \bisu@chapter*{\bisu@denotation@name}%
  \else
    \bisu@chapter*[]{\bisu@denotation@name}%
  \fi
  \vskip-30bp\xiaosi[1.6]\begin{bisu@denotation}[labelwidth=#1]
}{%
  \end{bisu@denotation}
}
\newlist{bisu@denotation}{description}{1}
\setlist[bisu@denotation]{%
  nosep,
  font=\normalfont,
  align=left,
  leftmargin=!, % sum of the following 3 lengths
  labelindent=0pt,
  labelwidth=2.5cm,
  labelsep*=0.5cm,
  itemindent=0pt,
}
\newcommand{\bisu@statement@text}{本人郑重声明：所呈交的学位论文，是本人在导师指导下
  ，独立进行研究工作所取得的成果。尽我所知，除文中已经注明引用的内容外，本学位论
  文的研究成果不包含任何他人享有著作权的内容。对本论文所涉及的研究工作做出贡献的
  其他个人和集体，均已在文中以明确方式标明。}
\newcommand{\bisu@signature}{签\hspace{1em}名：}
\newcommand{\bisu@backdate}{日\hspace{1em}期：}
\newenvironment{acknowledgements}{%
  \@mainmatterfalse
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
  \bisu@chapter*{\bisu@acknowledgements@name}%
}{%
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
}
\bisu@define@key{
  statement-page-style = {
    name = statement@page@style,
    choices = {
      auto,
      empty,
      plain,
    },
    default = auto,
  },
  statement-page-number = {
    name = statement@page@number,
    choices = {
      false,
      true,
    },
    default = false,
  },
}
\bisu@option@hook{statement-page-number}{%
  \ifbisu@statement@page@number@false
    \bisusetup{statement-page-style=empty}%
  \else
    \bisusetup{statement-page-style=plain}%
  \fi
  \bisu@warning{%
    The "statement-page-number" option is deprecated.
    Use "page-style" option of \protect\statement command instead%
  }%
}
\newcommand\statement[1][]{%
  \@mainmatterfalse
  \ifbisu@degree@bachelor
    \cleardoublepage
    \def\bisu@statement@name{声\hspace{2em}明}%
  \else
    \def\bisu@statement@name{声\hspace{1em}明}%
  \fi
  \let\bisu@statement@file\@empty
  \kv@define@key{bisu@statement}{page-style}{\bisusetup{statement-page-style=##1}}%
  \kv@define@key{bisu@statement}{file}{\let\bisu@statement@file\kv@value}%
  \kv@set@family@handler{bisu@statement}{%
    \ifx\kv@value\relax
      \let\bisu@statement@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{bisu@statement}{#1}%
  \ifbisu@statement@page@style@auto
    \ifx\bisu@statement@file\@empty
      \ifbisu@degree@bachelor
        \bisusetup{statement-page-style = empty}%
      \else
        \bisusetup{statement-page-style = plain}%
      \fi
    \else
      \ifbisu@degree@bachelor
        \bisusetup{statement-page-style = plain}%
      \else
        \bisusetup{statement-page-style = empty}%
      \fi
    \fi
  \fi
  \ifx\bisu@statement@file\@empty
    \bisusetup{language=chinese}%
    \begingroup
      \ifbisu@degree@graduate
        \ifbisu@main@language@english
          \ctexset{%
            chapter/format = \centering\sffamily\fontsize{16bp}{20bp}\selectfont,
          }%
        \fi
      \fi
      \bisu@chapter*{\bisu@statement@name}%
    \endgroup
    \thispagestyle{\bisu@statement@page@style}%
    \bisu@statement@text\par
    \ifbisu@degree@graduate
      \vskip 2cm%
    \else
      \null\par
    \fi
    {\hfill\bisu@signature\bisu@underline[2.5cm]\relax
      \bisu@backdate\bisu@underline[2.5cm]\relax}%
    \bisu@reset@main@language
  \else
    \includepdf[pagecommand={%
      \markboth{\bisu@statement@name}{}%
      \bisu@phantomsection
      \addcontentsline{toc}{chapter}{\bisu@statement@name}%
      \thispagestyle{\bisu@statement@page@style}%
    }]{\bisu@statement@file}%
  \fi
  \ifbisu@degree@bachelor
    \cleardoublepage
  \fi
}
\let\acknowledgement\acknowledgements
\let\endacknowledgement\endacknowledgements
\def\bisu@listof#1{% #1: float type
  \setcounter{tocdepth}{2} % restore tocdepth in case being modified
  \@ifstar
    {\bisu@chapter*[]{\csname list#1name\endcsname}\@starttoc{\csname ext@#1\endcsname}}
    {\bisu@chapter*{\csname list#1name\endcsname}\@starttoc{\csname ext@#1\endcsname}}%
}
\renewcommand\listoffigures{%
  \bisu@listof{figure}%
}
\titlecontents{figure}
  [\z@]{}
  {\contentspush{\figurename~\thecontentslabel\quad}}{}
  {\nobreak\bisu@leaders\nobreak\hfil\thecontentspage}
\renewcommand\listoftables{%
  \bisu@listof{table}%
}
\titlecontents{table}
  [\z@]{}
  {\contentspush{\tablename~\thecontentslabel\quad}}{}
  {\bisu@leaders\thecontentspage}
\newcommand\listoffiguresandtables{%
  \bisu@chapter*{\bisu@list@figure@table@name}%
  \@starttoc{lof}%
  \par
  \null\par
  \@starttoc{lot}%
}
\def\ext@equation{loe}
\def\equcaption#1{%
  \addcontentsline{\ext@equation}{equation}%
                  {\protect\numberline{#1}}}
\newcommand\listofequations{\bisu@listof{equation}}
\titlecontents{equation}
  [0pt]{\addvspace{6bp}}
  {\bisu@equation@name~\thecontentslabel}{}
  {\nobreak\bisu@leaders\nobreak\thecontentspage}
\contentsuse{equation}{loe}
  \bisu@define@key{
    cite-style = {
      name = cite@style,
      choices = {
        super,
        inline,
        author-year,
      }
    }
  }
\PassOptionsToPackage{compress}{natbib}
\AtEndOfPackageFile*{natbib}{
  \DeclareRobustCommand\inlinecite{\@inlinecite}
  \def\@inlinecite#1{\begingroup\let\@cite\NAT@citenum\citep{#1}\endgroup}
  \let\onlinecite\inlinecite
  \newcommand\bibstyle@super{%
    \bibpunct{[}{]}{,}{s}{,}{\textsuperscript{,}}}
  \newcommand\bibstyle@inline{%
    \bibpunct{[}{]}{,}{n}{,}{,}}
  \@namedef{bibstyle@author-year}{%
    \bibpunct{(}{)}{;}{a}{,}{,}}
  \bisu@option@hook{cite-style}{\@nameuse{bibstyle@\bisu@cite@style}}
  \@namedef{bibstyle@bisuthesis-numeric}{\citestyle{super}}
  \@namedef{bibstyle@bisuthesis-author-year}{\citestyle{author-year}}
  \@namedef{bibstyle@bisuthesis-bachelor}{\citestyle{super}}
  \@namedef{bibstyle@bisuthesis-inline}{\citestyle{inline}}
  \renewcommand\NAT@citesuper[3]{%
    \ifNAT@swa
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % \unskip\kern\p@\textsuperscript{\NAT@@open#1\NAT@@close}%
      %  \if*#3*\else\NAT@spacechar#3\fi\else #1\fi\endgroup}
      \unskip\kern\p@
      \textsuperscript{%
        \NAT@@open#1\NAT@@close
        \if*#3*\else#3\fi
      }%
      \kern\p@
    \else
      #1%
    \fi
    \endgroup
  }
  \renewcommand\NAT@citenum[3]{%
    \ifNAT@swa
      \NAT@@open
      \if*#2*\else
        #2\NAT@spacechar
      \fi
      % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close
      #1\NAT@@close
      \if*#3*\else
        \textsuperscript{#3}%
      \fi
    \else
      #1%
    \fi
    \endgroup
  }
  \def\NAT@citexnum[#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\def\NAT@num{-1}\let\NAT@last@yr\relax\let\NAT@nm\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{%
        {\reset@font\bfseries?}
          \NAT@citeundefined\PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}}%
      {\let\NAT@last@num\NAT@num\let\NAT@last@nm\NAT@nm
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
        \ifNAT@full\let\NAT@nm\NAT@all@names\else
          \let\NAT@nm\NAT@name\fi
        \ifNAT@swa
        \@ifnum{\NAT@ctype>\@ne}{%
          \@citea
          \NAT@hyper@{\@ifnum{\NAT@ctype=\tw@}{\NAT@test{\NAT@ctype}}{\NAT@alias}}%
        }{%
          \@ifnum{\NAT@cmprs>\z@}{%
          \NAT@ifcat@num\NAT@num
            {\let\NAT@nm=\NAT@num}%
            {\def\NAT@nm{-2}}%
          \NAT@ifcat@num\NAT@last@num
            {\@tempcnta=\NAT@last@num\relax}%
            {\@tempcnta\m@ne}%
          \@ifnum{\NAT@nm=\@tempcnta}{%
            \@ifnum{\NAT@merge>\@ne}{}{\NAT@last@yr@mbox}%
          }{%
            \advance\@tempcnta by\@ne
            \@ifnum{\NAT@nm=\@tempcnta}{%
              % \ifx\NAT@last@yr\relax
              %   \def@NAT@last@yr{\@citea}%
              % \else
              %   \def@NAT@last@yr{--\NAT@penalty}%
              % \fi
              \def@NAT@last@yr{-\NAT@penalty}%
            }{%
              \NAT@last@yr@mbox
            }%
          }%
          }{%
          \@tempswatrue
          \@ifnum{\NAT@merge>\@ne}{\@ifnum{\NAT@last@num=\NAT@num\relax}{\@tempswafalse}{}}{}%
          \if@tempswa\NAT@citea@mbox\fi
          }%
        }%
        \NAT@def@citea
        \else
          \ifcase\NAT@ctype
            \ifx\NAT@last@nm\NAT@nm \NAT@yrsep\NAT@penalty\NAT@space\else
              \@citea \NAT@test{\@ne}\NAT@spacechar\NAT@mbox{\NAT@super@kern\NAT@@open}%
            \fi
            \if*#1*\else#1\NAT@spacechar\fi
            \NAT@mbox{\NAT@hyper@{{\citenumfont{\NAT@num}}}}%
            \NAT@def@citea@box
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space{\NAT@test{\NAT@ctype}}%
          \or
            \NAT@hyper@citea@space\NAT@alias
          \fi
        \fi
      }%
      }%
        \@ifnum{\NAT@cmprs>\z@}{\NAT@last@yr}{}%
        \ifNAT@swa\else
          % \@ifnum{\NAT@ctype=\z@}{%
          %   \if*#2*\else\NAT@cmt#2\fi
          % }{}%
          \NAT@mbox{\NAT@@close}%
          \@ifnum{\NAT@ctype=\z@}{%
            \if*#2*\else
              \textsuperscript{#2}%
            \fi
          }{}%
          \NAT@super@kern
        \fi
    }{#1}{#2}%
  }%
  \renewcommand\NAT@cite%
      [3]{\ifNAT@swa\NAT@@open\if*#2*\else#2\NAT@spacechar\fi
          % #1\if*#3*\else\NAT@cmt#3\fi\NAT@@close\else#1\fi\endgroup}
          #1\NAT@@close\if*#3*\else\textsuperscript{#3}\fi\else#1\fi\endgroup}
  \def\NAT@citex%
    [#1][#2]#3{%
    \NAT@reset@parser
    \NAT@sort@cites{#3}%
    \NAT@reset@citea
    \@cite{\let\NAT@nm\@empty\let\NAT@year\@empty
      \@for\@citeb:=\NAT@cite@list\do
      {\@safe@activestrue
      \edef\@citeb{\expandafter\@firstofone\@citeb\@empty}%
      \@safe@activesfalse
      \@ifundefined{b@\@citeb\@extra@b@citeb}{\@citea%
        {\reset@font\bfseries ?}\NAT@citeundefined
                  \PackageWarning{natbib}%
        {Citation `\@citeb' on page \thepage \space undefined}\def\NAT@date{}}%
      {\let\NAT@last@nm=\NAT@nm\let\NAT@last@yr=\NAT@year
        \NAT@parse{\@citeb}%
        \ifNAT@longnames\@ifundefined{bv@\@citeb\@extra@b@citeb}{%
          \let\NAT@name=\NAT@all@names
          \global\@namedef{bv@\@citeb\@extra@b@citeb}{}}{}%
        \fi
      \ifNAT@full\let\NAT@nm\NAT@all@names\else
        \let\NAT@nm\NAT@name\fi
      \ifNAT@swa\ifcase\NAT@ctype
        \if\relax\NAT@date\relax
          \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}\NAT@date}%
        \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else\unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{%
                \NAT@aysep\NAT@spacechar}{\@citeb\@extra@b@citeb
              }%
              \NAT@date
            }%
          \fi
        \fi
      \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
      \or\@citea\NAT@hyper@{\NAT@date}%
      \or\@citea\NAT@hyper@{\NAT@alias}%
      \fi \NAT@def@citea
      \else
        \ifcase\NAT@ctype
          \if\relax\NAT@date\relax
            \@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
          \else
          \ifx\NAT@last@nm\NAT@nm\NAT@yrsep
              \ifx\NAT@last@yr\NAT@year
                \def\NAT@temp{{?}}%
                \ifx\NAT@temp\NAT@exlab\PackageWarningNoLine{natbib}%
                {Multiple citation on page \thepage: same authors and
                year\MessageBreak without distinguishing extra
                letter,\MessageBreak appears as question mark}\fi
                \NAT@hyper@{\NAT@exlab}%
              \else
                \unskip\NAT@spacechar
                \NAT@hyper@{\NAT@date}%
              \fi
          \else
            \@citea\NAT@hyper@{%
              \NAT@nmfmt{\NAT@nm}%
              \hyper@natlinkbreak{\NAT@spacechar\NAT@@open\if*#1*\else#1\NAT@spacechar\fi}%
                {\@citeb\@extra@b@citeb}%
              \NAT@date
            }%
          \fi
          \fi
        \or\@citea\NAT@hyper@{\NAT@nmfmt{\NAT@nm}}%
        \or\@citea\NAT@hyper@{\NAT@date}%
        \or\@citea\NAT@hyper@{\NAT@alias}%
        \fi
        \if\relax\NAT@date\relax
          \NAT@def@citea
        \else
          \NAT@def@citea@close
        \fi
      \fi
      }}\ifNAT@swa\else
        % \if*#2*\else\NAT@cmt#2\fi
        \if\relax\NAT@date\relax\else\NAT@@close\fi
        \if*#2*\else\textsuperscript{#2}\fi
      \fi}{#1}{#2}}
  \renewcommand\bibsection{\bisu@chapter*{\bibname}}
  \newcommand\bisu@set@bibliography@format{%
    \ifbisu@degree@bachelor
      \renewcommand\bibfont{\fontsize{10.5bp}{17bp}\selectfont}%
      \setlength{\bibsep}{6bp \@plus 3bp \@minus 3bp}%
      \ifbisu@main@language@chinese
        \setlength{\bibhang}{21bp}%
      \else
        \setlength{\bibhang}{0.5in}%
      \fi
    \else
      \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
      \setlength{\bibsep}{3bp \@plus 3bp \@minus 3bp}%
      \setlength{\bibhang}{21bp}%
    \fi
  }
  \bisu@set@bibliography@format
  \bisu@option@hook{degree}{\bisu@set@bibliography@format}
  \bisu@option@hook{main-language}{\bisu@set@bibliography@format}
  \patchcmd\thebibliography{%
    \clubpenalty4000%
  }{%
    \interlinepenalty=5000\relax
    \clubpenalty=10000\relax
  }{}{\bisu@patch@error{\thebibliography}}
  \patchcmd\thebibliography{%
    \widowpenalty4000%
  }{%
    \widowpenalty=10000\relax
  }{}{\bisu@patch@error{\thebibliography}}
  \def\@biblabel#1{[#1]\hfill}
  \renewcommand\NAT@bibsetnum[1]{%
    % \settowidth\labelwidth{\@biblabel{#1}}%
    % \setlength{\leftmargin}{\labelwidth}%
    % \addtolength{\leftmargin}{\labelsep}%
    \setlength{\leftmargin}{1cm}%
    \setlength{\itemindent}{\z@}%
    \setlength{\labelsep}{0.1cm}%
    \setlength{\labelwidth}{0.9cm}%
    \setlength{\itemsep}{\bibsep}
    \setlength{\parsep}{\z@}%
    \ifNAT@openbib
      \addtolength{\leftmargin}{\bibindent}%
      \setlength{\itemindent}{-\bibindent}%
      \setlength{\listparindent}{\itemindent}%
      \setlength{\parsep}{0pt}%
    \fi
  }
}
\AtEndOfPackageFile*{biblatex}{
  \AtBeginDocument{
    \ifthenelse{\equal{\blx@bbxfile}{apa}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{apa6}}{\def\bibname{REFERENCES}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla}}{\def\bibname{WORKS CITED}}{}
    \ifthenelse{\equal{\blx@bbxfile}{mla-new}}{\def\bibname{WORKS CITED}}{}
  }
  \DeclareRobustCommand\inlinecite{\parencite}
  \defbibheading{bibliography}[\bibname]{\bisu@chapter*{\bibname}}
  \newcommand\bisu@set@bibliography@format{%
    \ifbisu@degree@bachelor
      \renewcommand\bibfont{\fontsize{10.5bp}{17bp}\selectfont}%
      \setlength{\bibitemsep}{6bp \@plus 3bp \@minus 3bp}%
      \ifbisu@main@language@chinese
        \setlength{\bibhang}{21bp}%
      \else
        \setlength{\bibhang}{0.5in}%
      \fi
    \else
      \renewcommand\bibfont{\fontsize{10.5bp}{16bp}\selectfont}%
      \setlength{\bibitemsep}{3bp \@plus 3bp \@minus 3bp}%
      \setlength{\biblabelsep}{0.1cm}%
      \setlength{\bibhang}{21bp}%
    \fi
  }
  \bisu@set@bibliography@format
  \bisu@option@hook{degree}{\bisu@set@bibliography@format}
  \bisu@option@hook{main-language}{\bisu@set@bibliography@format}
}
\AtEndOfPackageFile*{apacite}{
  \AtBeginDocument{
    \bisu@set@chapter@names
  }
  \renewcommand\bibliographytypesize{\fontsize{10.5bp}{17bp}\selectfont}
  \setlength{\bibitemsep}{6bp}
  \ifbisu@main@language@chinese
    \setlength{\bibleftmargin}{21bp}
    \setlength{\bibindent}{-\bibleftmargin}
  \else
    \setlength{\bibleftmargin}{0.5in}
    \setlength{\bibindent}{-\bibleftmargin}
  \fi
  \def\st@rtbibchapter{%
    \if@numberedbib%
      \chapter{\bibname}%   e.g.,   6. References
    \else%
      \bisu@chapter*{\bibname}%   e.g.,   References
    \fi%
  }%
}
\g@addto@macro\appendix{%
  \@mainmattertrue
}
\bisu@define@key{
  toc-depth = {
    name = toc@depth,
  },
}
\bisu@option@hook{toc-depth}{%
  \protected@write\@auxout{}{%
    \string\ttl@writefile{toc}{%
      \protect\setcounter{tocdepth}{\bisu@toc@depth}%
    }%
  }%
  \addtocontents{lof}{\string\let\string\contentsline\string\ttl@gobblecontents}
  \addtocontents{lot}{\string\let\string\contentsline\string\ttl@gobblecontents}
  \addtocontents{loe}{\string\let\string\contentsline\string\ttl@gobblecontents}
}
\g@addto@macro\appendix{%
  \bisusetup{
    toc-depth = 0,
  }%
}
\newenvironment{survey}{%
  \chapter{外文资料的调研阅读报告}%
  \bisusetup{language = english}%
  \let\title\bisu@appendix@title
  \let\maketitle\bisu@appendix@maketitle
  \bisu@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{Contents}%
    \bisu@pdfbookmark{1}{Contents}%
    \printcontents[survey]{l}{1}[2]{}%
    \vskip 20bp%
  }%
  \renewcommand\bibname{参考文献}%
  \let\bibsection\bisu@appendix@bibsection
  \renewcommand\@bibunitname{\jobname-survey}%
  \let\bibliographystyle\defaultbibliographystyle
  \let\bibliography\bisu@appendix@bibliography
  \begin{bibunit}%
  \startcontents[survey]%
}{%
  \stopcontents[survey]%
  \end{bibunit}%
  \bisu@reset@main@language % restore language
}
\newenvironment{translation}{%
  \chapter{外文资料的书面翻译}%
  \bisusetup{language = chinese}%
  \let\title\bisu@appendix@title
  \let\maketitle\bisu@appendix@maketitle
  \bisu@set@partial@toc@format
  \renewcommand\tableofcontents{%
    \section*{目录}%
    \bisu@pdfbookmark{1}{目录}%
    \printcontents[translation]{l}{1}[2]{}%
    \vskip 20bp%
  }%
  \def\bibsection{%
    \begingroup
      \ctexset{section/numbering=false}%
      \section{\bibname}%
    \endgroup
  }%
  \renewcommand\@bibunitname{\jobname-translation}%
  \let\bibliographystyle\defaultbibliographystyle
  \let\bibliography\bisu@appendix@bibliography
  \begin{bibunit}%
  \startcontents[translation]%
}{%
  \stopcontents[translation]%
  \end{bibunit}%
  \bisu@reset@main@language % restore language
}
\newenvironment{translation-index}{%
  \begin{bibunit}%
    \renewcommand\@bibunitname{\jobname-index}%
    \renewcommand\bibname{书面翻译对应的原文索引}%
    \let\bibsection\bisu@appendix@bibsection
}{%
  \end{bibunit}%
}
\DeclareRobustCommand\bisu@appendix@title[1]{\gdef\bisu@appendix@@title{#1}}
\newcommand\bisu@appendix@maketitle{%
  \par
  \begin{center}%
    \xiaosi[1.667]\bisu@appendix@@title
  \end{center}%
  \par
}
\newcommand\bisu@set@partial@toc@format{%
  \titlecontents{section}
    [\z@]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\bisu@leaders\thecontentspage}%
  \titlecontents{subsection}
    [1em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\bisu@leaders\thecontentspage}%
  \titlecontents{subsubsection}
    [2em]{}
    {\contentspush{\thecontentslabel\quad}}{}
    {\bisu@leaders\thecontentspage}%
}
\newcommand\bisu@appendix@bibsection{%
  \par
  \vskip 20bp%
  \bisu@pdfbookmark{1}{\bibname}%
  \begingroup
    \centering
    \xiaosi[1.667]\bibname\par
  \endgroup
  \vskip 6bp%
}%
\newcommand\bisu@appendix@bibliography[1]{\putbib[#1]}
\newenvironment{resume}{%
  \@mainmatterfalse
  \bisu@chapter*{\bisu@resume@name}%
  \ctexset{
    section = {
      format    += \centering,
      numbering = false,
    },
    subsection = {
      format     = \sffamily\fontsize{14bp}{20bp}\selectfont,
      numbering  = false,
      aftertitle = \ifbisu@language@chinese ：\else :\fi,
    },
  }%
  \ifbisu@degree@bachelor
    \ifbisu@language@english
      \sffamily\fontsize{15bp}{20bp}\selectfont,
    \fi
  \fi
}{}
\newcommand\resumeitem[1]{%
  \bisu@error{The "\protect\resumeitem" is obsolete. Please update to the new format}%
}
\newcommand\researchitem[1]{%
  \bisu@error{The "\protect\researchitem" is obsolete. Please update to the new format}%
}
\newlist{achievements}{enumerate}{1}
\setlist[achievements]{
  label      = [\arabic*],
  align      = left,
  leftmargin = 10mm,
  topsep     = 6bp,
  parsep     = 0bp,
  partopsep  = 0bp,
  itemsep    = 6bp,
  labelsep   = !,
  before     = {
    \ifbisu@degree@graduate
      \fontsize{12bp}{16bp}\selectfont
    \fi
  },
  resume     = achievements,
}
\newenvironment{publications}{%
  \bisu@deprecate{"publications" environment}{"achievements"}%
  \begin{achievements}%
}{%
  \end{achievements}%
}
\newcommand\publicationskip{%
  \bisu@error{The "\protect\publicationskip" is obsolete. Do not use it}%
}
\newenvironment{comments}[1][]{%
  \@mainmatterfalse
  \kv@define@key{bisu@comments}{name}{\let\bisu@comments@name\kv@value}%
  \kv@set@family@handler{bisu@comments}{%
    \ifx\kv@value\relax
      \let\bisu@comments@name\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{bisu@comments}{#1}%
  \chapter{\bisu@comments@name}%
}{%
}
\newenvironment{resolution}{%
  \@mainmatterfalse
  \chapter{\bisu@resolution@name}%
}{}
\newcommand{\record}[1]{%
  \let\bisu@record@file\@empty
  \kv@define@key{bisu@record}{file}{\let\bisu@record@file\kv@value}%
  \kv@set@family@handler{bisu@record}{%
    \ifx\kv@value\relax
      \let\bisu@record@file\kv@key
    \else
      \kv@handled@false
    \fi
  }%
  \kvsetkeys{bisu@record}{#1}%
  \ifx\bisu@record@file\@empty
    \bisu@error{File path of \protect\record\space is required}
  \fi
  \cleardoublepage
  \bisu@pdfbookmark{0}{综合论文训练记录表}%
  \includepdf[pages=-]{\bisu@record@file}%
}
\AtEndOfPackageFile*{hyperref}{
  \hypersetup{
    linktoc            = all,
    bookmarksdepth     = 2,
    bookmarksnumbered  = true,
    bookmarksopen      = true,
    bookmarksopenlevel = 1,
    bookmarksdepth     = 3,
    unicode            = true,
    psdextra           = true,
    breaklinks         = true,
    plainpages         = false,
    pdfdisplaydoctitle = true,
    hidelinks,
  }%
  \newcounter{bisu@bookmark}
  \renewcommand\bisu@pdfbookmark[2]{%
    \phantomsection
    \stepcounter{bisu@bookmark}%
    \pdfbookmark[#1]{#2}{bisuchapter.\thebisu@bookmark}%
  }
  \renewcommand\bisu@phantomsection{%
    \phantomsection
  }
  \pdfstringdefDisableCommands{
    \let\\\relax
    \let\quad\relax
    \let\hspace\@gobble
  }%
  \@ifpackagelater{hyperref}{2019/04/27}{}{%
    \g@addto@macro\psdmapshortnames{\let\mu\textmu}
  }%
  \ifbisu@main@language@chinese
    \hypersetup{
      pdflang = zh-CN,
    }%
  \else
    \hypersetup{
      pdflang = en-US,
    }%
  \fi
  \AtBeginDocument{%
    \ifbisu@main@language@chinese
      \hypersetup{
        pdftitle    = \bisu@title,
        pdfauthor   = \bisu@author,
        pdfsubject  = \bisu@degree@name,
        pdfkeywords = \bisu@keywords,
      }%
    \else
      \hypersetup{
        pdftitle    = \bisu@title@en,
        pdfauthor   = \bisu@author@en,
        pdfsubject  = \bisu@degree@name@en,
        pdfkeywords = \bisu@keywords@en,
      }%
    \fi
    \hypersetup{
      pdfcreator={\bisuthesis-v\version}}
  }%
}
\AtEndOfPackageFile*{nomencl}{
  \let\nomname\bisu@denotation@name
  \def\thenomenclature{\begin{denotation}[\nom@tempdim]}
  \def\endthenomenclature{\end{denotation}}
}
\AtEndOfPackageFile*{siunitx}{%
  \sisetup{
    group-minimum-digits = 4,
    separate-uncertainty = true,
    inter-unit-product   = \ensuremath{{}\cdot{}},
  }
  \newcommand\bisu@set@siunitx@language{%
    \ifbisu@language@chinese
      \sisetup{
        list-final-separator = { 和 },
        list-pair-separator  = { 和 },
        range-phrase         = {～},
      }%
    \else
      \ifbisu@language@english
        \sisetup{
          list-final-separator = {, and },
          list-pair-separator  = { and },
          range-phrase         = { to },
        }%
      \fi
    \fi
  }
  \bisu@set@siunitx@language
  \bisu@option@hook{language}{\bisu@set@siunitx@language}
}
\AtEndOfPackageFile*{amsthm}{%
  \newtheoremstyle{bisu}
    {\z@}{\z@}
    {\normalfont}{\z@}
    {\normalfont\sffamily}{\bisu@theorem@separator}
    {0.5em}{}
  \theoremstyle{bisu}
  \newtheorem{assumption}{\bisu@assumption@name}[chapter]%
  \newtheorem{definition}{\bisu@definition@name}[chapter]%
  \newtheorem{proposition}{\bisu@proposition@name}[chapter]%
  \newtheorem{lemma}{\bisu@lemma@name}[chapter]%
  \newtheorem{theorem}{\bisu@theorem@name}[chapter]%
  \newtheorem{axiom}{\bisu@axiom@name}[chapter]%
  \newtheorem{corollary}{\bisu@corollary@name}[chapter]%
  \newtheorem{exercise}{\bisu@exercise@name}[chapter]%
  \newtheorem{example}{\bisu@example@name}[chapter]%
  \newtheorem{remark}{\bisu@remark@name}[chapter]%
  \newtheorem{problem}{\bisu@problem@name}[chapter]%
  \newtheorem{conjecture}{\bisu@conjecture@name}[chapter]%
  \renewenvironment{proof}[1][\bisu@proof@name]{\par
    \pushQED{\qed}%
    % \normalfont \topsep6\p@\@plus6\p@\relax
    \normalfont \topsep\z@\relax
    \trivlist
    \item[\hskip\labelsep
      %     \itshape
      % #1\@addpunct{.}]\ignorespaces
      \sffamily
      #1\@addpunct{\bisu@theorem@separator}]\ignorespaces
  }{%
    \popQED\endtrivlist\@endpefalse
  }
  \renewcommand\qedsymbol{\bisu@qed}
}
\AtEndOfPackageFile*{ntheorem}{%
  \theorembodyfont{\normalfont}%
  \theoremheaderfont{\normalfont\sffamily}%
  \theoremsymbol{\bisu@qed}%
  \newtheorem*{proof}{\bisu@proof@name}%
  \theoremstyle{plain}%
  \theoremsymbol{}%
  \theoremseparator{\bisu@theorem@separator}%
  \newtheorem{assumption}{\bisu@assumption@name}[chapter]%
  \newtheorem{definition}{\bisu@definition@name}[chapter]%
  \newtheorem{proposition}{\bisu@proposition@name}[chapter]%
  \newtheorem{lemma}{\bisu@lemma@name}[chapter]%
  \newtheorem{theorem}{\bisu@theorem@name}[chapter]%
  \newtheorem{axiom}{\bisu@axiom@name}[chapter]%
  \newtheorem{corollary}{\bisu@corollary@name}[chapter]%
  \newtheorem{exercise}{\bisu@exercise@name}[chapter]%
  \newtheorem{example}{\bisu@example@name}[chapter]%
  \newtheorem{remark}{\bisu@remark@name}[chapter]%
  \newtheorem{problem}{\bisu@problem@name}[chapter]%
  \newtheorem{conjecture}{\bisu@conjecture@name}[chapter]%
}
\PassOptionsToPackage{chapter}{algorithm}
\AtEndOfPackageFile*{algorithm}{
  \floatname{algorithm}{\bisu@algorithm@name}
  \renewcommand\listofalgorithms{%
    \bisu@listof{algorithm}%
  }
  \renewcommand\listalgorithmname{\bisu@list@algorithm@name}
  \def\ext@algorithm{loa}
  \contentsuse{algorithm}{loa}
  \titlecontents{algorithm}
    [\z@]{}
    {\contentspush{\fname@algorithm~\thecontentslabel\quad}}{}
    {\bisu@leaders\thecontentspage}
}
\PassOptionsToPackage{algochapter}{algorithm2e}
\AtEndOfPackageFile*{algorithm2e}{
  \renewcommand\algorithmcfname{\bisu@algorithm@name}
  \SetAlgoCaptionLayout{bisu@caption@font}
  \SetAlCapSty{relax}
  \SetAlgoCaptionSeparator{\hspace*{1em}}
  \SetAlFnt{\fontsize{11bp}{14.3bp}\selectfont}
  \renewcommand\listofalgorithms{%
    \bisu@listof{algorithmcf}%
  }
  \renewcommand\listalgorithmcfname{\bisu@list@algorithm@name}
  \def\ext@algorithmcf{loa}
  \contentsuse{algocf}{loa}
  \titlecontents{algocf}
    [\z@]{}
    {\contentspush{\algorithmcfname~\thecontentslabel\quad}}{}
    {\bisu@leaders\thecontentspage}
}
\AtEndOfPackageFile*{minted}{
  \newcommand\bisu@set@listing@language{%
    \ifbisu@language@chinese
      \floatname{listing}{代码}%
    \else
      \floatname{listing}{Listing}%
    \fi
  }
  \bisu@set@listing@language
  \bisu@option@hook{language}{\bisu@set@listing@language}
}
\bisu@define@key{
  spine-font = {
    name = spine@font,
    default = {\sanhao},
  },
  spine-title = {
    name = spine@title,
  },
  spine-author = {
    name = spine@author,
  },
}
\newcommand*\CJKmovesymbol[1]{\raise.3em\hbox{#1}}
\newcommand*\CJKmove{%
  \punctstyle{plain}%
  \let\CJKsymbol\CJKmovesymbol
  \let\CJKpunctsymbol\CJKsymbol
}
\NewDocumentCommand{\spine}{
    O{
      \ifx\bisu@spine@title\@empty
        \bisu@title
      \else
        \bisu@spine@title
      \fi
    }
    O{
      \ifx\bisu@spine@author\@empty
        \bisu@author
      \else
        \bisu@spine@author
      \fi
    }}{%
  \clearpage
  \ifbisu@degree@bachelor
    \newgeometry{
      vmargin = 3cm,
      hmargin = 1cm,
    }%
  \else
    \newgeometry{
      vmargin = 5.5cm,
      hmargin = 1cm,
    }%
  \fi
  \thispagestyle{empty}%
  \ifbisu@main@language@chinese
    \bisu@pdfbookmark{0}{书脊}%
  \else
    \bisu@pdfbookmark{0}{Spine}%
  \fi
  \begingroup
    \noindent\hfill
    \rotatebox[origin=lt]{-90}{%
      \makebox[\textheight]{%
        \fangsong
        \addCJKfontfeatures*{RawFeature={vertical}}%
        \bisu@spine@font
        \CJKmove
        #1\hfill
        \bisu@stretch{4.5em}{#2}%
      }%
    }%
  \endgroup
  \clearpage
  \restoregeometry
}
\newcommand\bisu@input@spine{%
  \IfFileExists{spine.pdf}{}{%
    \immediate\write18{xelatex spine.tex}%
    \IfFileExists{spine.pdf}{}{%
      \bisu@error{Cannot find file "spine.pdf". Compile "spine.tex" first, or enable shell escape}%
    }%
  }%
  \includepdf[pages=1]{spine.pdf}%
}
\newcommand\bisu@spine{%
  \ifbisu@cjk@font@fandol
    \bisu@input@spine
  \else
    \ifbisu@cjk@font@noto
      \bisu@input@spine
    \else
      \spine
    \fi
  \fi
}
\DeclareRobustCommand\cs[1]{\texttt{\char`\\#1}}
\DeclareRobustCommand\file{\nolinkurl}
\DeclareRobustCommand\env{\textsf}
\DeclareRobustCommand\pkg{\textsf}
\DeclareRobustCommand\cls{\textsf}
\sloppy
\endinput
%%
%% End of file `bisuthesis.cls'.
