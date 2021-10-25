## vscode 插件

- Vetur  Vue多功能集成插件
- ESLint js语法纠错
- Auto Rename Tag  自动重命名配对的HTML / XML标签
- HTML CSS Support   在编写样式表的时候，自动补全功能大大缩减了编写时间
- open in browser  浏览器中打开html
- prettier  格式化代码



格式化代码配置

```
{
    //强制单引号
    "prettier.singleQuote":true,
    //尽可能控制尾随逗号的打印
    "prettier.trailingComma":"all",
    //开启eslint支持
    "prettier.eslintIntegration":true,
    //使用插件格式化html
    "vetur.format.defaultFormatter.html":"js-beautify-html",
    //格式化插件的配置
    "vetur.format.defaultFormatterOptions":{
        "js-beautify-html":{
        //属性强制折行对齐
        "wrap_attributes":"force-aligned",
        }
    },
    "editor.codeActionsOnSave":{
        "source.fixAll.eslint":true
        },
        "vetur.validation.template": false
    }
}
```

