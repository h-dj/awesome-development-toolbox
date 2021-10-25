### live template 模板收集

#### 常用模板
- 快速编写 GET请求
```shell

@GetMapping("$path$")
public String $methodName$(Model model,HttpServletRequest request,HttpServletResponse response) {
    return $END$;
}
```
- Post请求
```shell

@PostMapping("$paht$")
@ResponseBody
public BaseResponse $methodName$(@RequestBody $varType$ $var$) {
        $END$
    return BaseResponse.SUCCESS_RESPONSE;
}
```