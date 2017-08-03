module.exports = {
  config: {
    // default font size in pixels for all tabs
    fontSize: 15,

    // font family with optional fallbacks
    fontFamily: 'Fira Code',

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: 'BLOCK',

    // terminal cursor background color (hex)
    cursorColor: '#add877',

    // color of the text
    foregroundColor: '#c4e2f2',

    // terminal background color
    backgroundColor: '#fafafa',

    // border color (window, tabs)
    borderColor: '#335E69',

    // custom css to embed in the main window
    css: `
    `,

    // custom css to embed in the terminal window
    termCSS: `
      * {
        -webkit-font-feature-settings: "liga" on, "calt" on, "dlig" on !important;
        text-rendering: optimizeLegibility !important;
      }
      x-row {
       // line-height: 1.2em;
      }
    `,

    // set to `true` if you're using a Linux set up
    // that doesn't shows native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: '',

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // OGP
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: 'false',

    // custom padding (css format, i.e.: `top right bottom left`)
    //padding: '.5rem',

    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: [
      '#26292c',
      '#f69648',
      '#add877',
      '#f6f080',
      '#60a7ca',
      '#7d72c8',
      '#e05178',
      '#ffffff',
      '#262721',
      '#dc412f',
      '#b5d839',
      '#ff9c5a',
      '#ff9c5a',
      '#7d72c8',
      '#e05178',
      '#ffffff'
    ],

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: '/bin/zsh',

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ['--login'],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: 'SOUND',

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    keymap: {
      // just examples, see below for detailed explanation
      'CmdOrCtrl+Alt+[':  'prev-pane',
      'CmdOrCtrl+Alt+]': 'next-pane',
    },

    // for advanced config flags please refer to https://hyper.is/#cfg
    summonShortcut: 'Control+Esc',

    paneNavigation: {
      debug: true,
      hotkeys: {
        navigation: {
          up: 'ctrl+alt+up',
          down: 'ctrl+alt+down',
          left: 'ctrl+[',
          right: 'ctrl+]'
        },
      },
    }
  },

  // a list of plugins to fetch and install from npm
  // format: [@org/]project[#version]
  // examples:
  //   `hyperpower`
  //   `@company/project`
  //   `project#1.0.1`
  plugins: [
    'gitrocket',
    'hypercwd',
    'hyperline',
    'hyperlinks',
    'hyperterm-tabs',
    'hyperminimal',
    'hyper-pane',
    'hyper-material'
  ],

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [
  ]
};
