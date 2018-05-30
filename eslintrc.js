module.exports = {
  env: {
    browser: true,
    es6: true,
    node: true
  },
  extends: ["eslint:recommended", "plugin:react/recommended"],
  parser: "babel-eslint",
  parserOptions: {
    parserOptions: {
      typescript: true
    },
    ecmaFeatures: {
      experimentalObjectRestSpread: true,
      classes: true,
      jsx: true
    },
    sourceType: "module"
  },
  //  plugins: [ 'react', 'jest', 'class-property' ],
  plugins: ["prettier"],
  rules: {
    "prettier/prettier": "error"
  }
};
