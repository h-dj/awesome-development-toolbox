##### 1、实现tip 效果
```html
<style>
    .description{
    overflow : hidden;
    text-overflow: ellipsis;
    word-break: break-all;
    display: -webkit-box;
    -webkit-line-clamp:4; /* 行数*/
    -webkit-box-orient: vertical;
    list-style: none;
}
</style>
<a href="javascript:void(0);" title="测试" class="description">测试</a>

```