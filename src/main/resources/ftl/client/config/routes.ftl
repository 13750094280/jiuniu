export default [
  {
    path: "/${clazz.flName}",
    component: resolve => require(["../page.vue"], resolve),
    meta: {
      title: "${clazz.comment!}"
    }
  },
  {
    path: "/${clazz.flName}/:id",
    component: resolve => require(["../edit.vue"], resolve),
    meta: {
      title: "${clazz.comment!}编辑"
    }
  }
];
