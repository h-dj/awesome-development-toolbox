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