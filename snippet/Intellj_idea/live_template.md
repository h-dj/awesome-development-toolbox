### live template ģ���ռ�

#### ����ģ��
- ���ٱ�д GET����
```shell

@GetMapping("$path$")
public String $methodName$(Model model,HttpServletRequest request,HttpServletResponse response) {
    return $END$;
}
```
- Post����
```shell

@PostMapping("$paht$")
@ResponseBody
public BaseResponse $methodName$(@RequestBody $varType$ $var$) {
        $END$
    return BaseResponse.SUCCESS_RESPONSE;
}
```

- ��ӡ��ά����
```shell

for(int $INDEX$ = 0; $INDEX$ < $ARR$.length; $INDEX$++) {
    for(int $INDEX2$ = 0; $INDEX2$ < $ARR$[$INDEX$].length; $INDEX2$++) {
        System.out.print($ARR$[$INDEX$]);
    }
    System.out.println();
}
```