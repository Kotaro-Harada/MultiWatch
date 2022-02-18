const VueLoaderPlugin = require('vue-loader/lib/plugin')
const path = require('path')
const webpack = require('webpack')

module.exports = {
  mode: 'production',
  entry: [ './packs/application.js'],
  output: {
    path: path.resolve(__dirname, './asset'),
  },
  module: {
    rules:
    [
      {
        test: /\.vue$/,
        loader: "vue-loader"
      },
      {
        test: /\.js$/,
        loader: "babel-loader"
      }
    ]
  },
  plugins: [
    new VueLoaderPlugin()
  ]
}
