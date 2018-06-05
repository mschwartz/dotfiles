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
    "prettier/prettier": "error",
    "linebreak-style": ["error", "unix"],
    semi: ["error", "always"],
    "no-constant-condition": ["error", { checkLoops: false }],
    "no-debugger": 0,
    "jsx-quotes": 1,
    // 'class-properties/semi: ["error", "never"]',
    "react/display-name": 0,
    // 'react/forbid-prop-types':            0,
    "react/jsx-boolean-value": 1,
    "react/jsx-closing-bracket-location": 1,
    "react/jsx-curly-spacing": 1,
    "react/jsx-handler-names": 1,
    "react/jsx-indent-props": [2, 2],
    "react/jsx-indent": [2, 2],
    "react/jsx-key": 1,
    // 'react/jsx-max-props-per-line':       0,
    "react/jsx-no-bind": 1,
    "react/jsx-no-duplicate-props": 1,
    "react/jsx-no-literals": 1,
    "react/jsx-no-undef": 1,
    "react/jsx-pascal-case": 1,
    //     'react/jsx-sort-prop-types':          0,
    //     'react/jsx-sort-props':               0,

    "react/jsx-uses-react": 1,
    "react/jsx-uses-vars": 1,
    "react/no-danger": 1,
    "react/no-deprecated": 1,
    "react/no-did-mount-set-state": 1,
    "react/no-did-update-set-state": 1,
    "react/no-direct-mutation-state": 1,
    "react/no-is-mounted": 1,
    // 'react/no-multi-comp':                0,
    // 'react/no-set-state':                 1,
    "react/no-string-refs": 1,
    "react/no-unknown-property": 1,
    "react/prefer-es6-class": 1,
    "react/prop-types": 1,
    "react/react-in-jsx-scope": 1,
    // 'react/require-extension':            1,
    "react/self-closing-comp": 1,
    "react/sort-comp": 1
    // 'react/wrap-multilines':              1
  }
};
