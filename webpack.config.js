const dev = process.env.NODE_ENV == 'dev';
const path = require('path');
const webpack = require('webpack');
const CopyWebpackPlugin = require('copy-webpack-plugin');

let config = {
    entry: './src/Fnx.coffee',
    target: 'web',
    node: {
        global: true,
        Buffer: true
    },
    output: {
        path: path.resolve('./dist'),
        library: 'FNX',
        filename: `fnx.js`
    },
    module: {
        rules: [
            {test: /\.coffee$/, use: 'coffee-loader'},
            {test: /\.js$/, use: 'babel-loader'}
        ]
    },
    plugins: [
        new CopyWebpackPlugin([
            {
                from: path.resolve('./src/game'),
                to: path.resolve('./dist/game'),
            },
            {
                from: path.resolve('./src/res'),
                to: path.resolve('./dist/res'),
            }
        ])
    ]
};

if(!dev)
    config.plugins.push(
        new webpack.optimize.UglifyJsPlugin({
            compress: {
                warnings: false
            }
        })
    );
else
    config.devtool = 'source-map';

module.exports = config;