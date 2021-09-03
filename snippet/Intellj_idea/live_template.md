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

- 打印二维数组
```shell

for(int $INDEX$ = 0; $INDEX$ < $ARR$.length; $INDEX$++) {
    for(int $INDEX2$ = 0; $INDEX2$ < $ARR$[$INDEX$].length; $INDEX2$++) {
        System.out.print($ARR$[$INDEX$]);
    }
    System.out.println();
}
```