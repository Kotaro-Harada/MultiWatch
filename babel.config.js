module.exports = function(api) {
  var validEnv = ['development', 'test', 'production']
  var currentEnv = api.env()
  var isDevelopmentEnv = api.env('development')
  var isProductionEnv = api.env('production')
  var isTestEnv = api.env('test')

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      'Please specify a valid `NODE_ENV` or ' +
        '`BABEL_ENV` environment variables. Valid values are "development", ' +
        '"test", and "production". Instead, received: ' +
        JSON.stringify(currentEnv) +
        '.'
    )
  }

  return {
    presets: [
      isTestEnv && [
        '@babel/preset-env', {
          "modules": false,
          targets: {
            node: 'current'
          },
          "useBuiltIns": "entry",
          'corejs': 2,
        }
      ],
      (isProductionEnv || isDevelopmentEnv) && [
        '@babel/preset-env', {
          forceAllTransforms: true,
          useBuiltIns: "entry",
          "modules": false,
          exclude: ['transform-typeof-symbol']
        }
      ]
    ].filter(Boolean),
    plugins: [
      'babel-plugin-macros',
      '@babel/plugin-syntax-dynamic-import',
      isTestEnv && 'babel-plugin-dynamic-import-node',
      '@babel/plugin-transform-destructuring',
      [
        '@babel/plugin-proposal-class-properties',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-proposal-object-rest-spread',
        {
          useBuiltIns: true
        }
      ],
      [
        '@babel/plugin-proposal-private-methods',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-proposal-private-property-in-object',
        {
          loose: true
        }
      ],
      [
        '@babel/plugin-transform-runtime',
        {
          helpers: false
        }
      ],
      [
        '@babel/plugin-transform-regenerator',
        {
          async: false
        }
      ]
    ].filter(Boolean)
  }
}

module.exports = {
  presets: [
    [
      '@babel/preset-env', {
        "modules": false,
        'useBuiltIns': "entry",
        'corejs': 2,
        'targets': '> 0.25%, not dead',
      },
    ],
    "@vue/cli-plugin-babel/preset",
    'jest'
  ],
  env: {
    test: {
      presets: [
        [
          '@babel/preset-env', {
            "modules": false,
            targets: {
              node: 'current'
            },
            "useBuiltIns": "entry",
            'corejs': 2,
          }
        ]
      ],
    },
  },
};
