const path = require('path');
const CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
    entry: './src/Fnx.coffee',
    output: {
        path: path.resolve('./dist'),
        library: 'FNX',
        filename: 'fnx.js'
    },
    devtool: "source-map",
    module: {
        rules: [
            {
                test: /\.coffee$/,
                use: 'coffee-loader'
            }
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