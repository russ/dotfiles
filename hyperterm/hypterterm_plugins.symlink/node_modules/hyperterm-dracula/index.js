/**

*/

'use strict';

const backgroundColor = '#282a36'
  , foregroundColor = '#f8f8f2'
  , currentLine = '#44475a'
  // colors
  , cyan = '#8be9fd'
  , green = '#50fa7b'
  , orange = '#ffb86c'
  , pink = '#ff79c6'
  , purple = '#bd93f9'
  , red = '#ff5555'
  , yellow = '#f1fa8c';

exports.decorateConfig = config => {
  return Object.assign({}, config, {
    backgroundColor,
    foregroundColor,
    borderColor: backgroundColor,
    cursorColor: currentLine,
    colors: [
      cyan,
      green,
      orange,
      pink,
      purple,
      red,
      yellow
    ],
    css: `
			${config.css || ''}
			.tab_active:before {
				border-color: rgba(255, 106, 193, 0.25);
			}
		`
  });
}
