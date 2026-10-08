# Misskey Custom Modifications

基于 [Misskey](https://github.com/misskey-dev/misskey) 的实例定制记录。

本文记录本实例对 Misskey 前端和后端所做的功能修改，便于后续维护、迁移和合并上游更新。

## 1. 登录页友情链接

在访客登录页中央面板左上角增加“友情链接”按钮，点击后打开与论坛风格一致的弹窗。

当前硬编码友链：

- 心墙：https://ooon.top/

弹窗标题栏右侧提供关闭按钮，链接使用新标签页打开。

涉及文件：

- `packages/frontend/src/components/MkVisitorDashboard.vue`
- `packages/frontend/src/components/MkFriendLinksDialog.vue`

## 2. 登录页面板布局

登录页的大容器使用 `MkVisitorDashboard.vue` 中的 `.main.panel`，友情链接按钮固定在面板左上角，原有菜单按钮保留在右上角。

相关样式：

- `.main`
- `.panel`
- `.friendLinks`
- `.mainMenu`

## 3. 通知页栏目名称修正

将通知页中原本容易与 Chat 私信混淆的栏目名称：

```text
私信
```

改为：

```text
仅我可见
```

筛选逻辑保持不变，仍然使用指定可见帖子查询：

```text
notes/mentions
visibility: specified
```

该栏目不是 `/chat` 私信聊天列表。

涉及文件：

- `locales/zh-CN.yml`

## 4. 顶部栏天线入口改为相册

将普通时间线顶部栏中的天线入口替换为相册入口。

修改后的配置：

- 图标：`ti ti-icons`
- 标题：`i18n.ts.gallery`
- 路由：`/gallery`

顶部栏顺序中的对应入口变为：

```text
相册 -> /gallery
```

私信和频道入口保持不变。

涉及文件：

- `packages/frontend/src/pages/timeline.vue`


## 5. 北半球季节性画面效果

保留 Misskey 原有的季节性画面效果，并补充秋季枫叶效果。

北半球效果：

| 月份 | 效果 |
| --- | --- |
| 1 月、12 月 | 雪花 |
| 3 月、4 月 | 樱花 |
| 9 月、10 月、11 月 | 橙红色枫叶 |

南半球效果：

| 月份 | 效果 |
| --- | --- |
| 3 月、4 月、5 月 | 橙红色枫叶 |
| 7 月、8 月 | 雪花 |

秋叶使用现有 WebGL Canvas 飘落系统绘制，不依赖外部图片资源，包含：

- 五个尖角叶瓣
- 叶瓣之间的凹槽
- 中央叶脉
- 叶柄
- 旋转、飘落和风吹效果

效果受用户偏好中的“符合当前季节的画面效果”控制。季节判断使用浏览器运行时日期，因此测试时可以临时修改设备日期，测试完成后应恢复自动日期和时间。

涉及文件：

- `packages/frontend/src/boot/main-boot.ts`
- `packages/frontend/src/utility/snowfall-effect.ts`
- `packages/frontend/src/utility/snowfall-effect.fragment.glsl`

## 6. 邮件模板中文化

将常规邮件中面向用户显示的英文标题和正文改为中文，同时保留原有链接、变量和 HTML 结构。

已中文化的邮件包括：

- 注册确认：`完成注册`
- 邮箱验证：`验证邮箱地址`
- 密码重置：`密码重置请求`
- 新登录提醒：`新登录提醒`
- 账号删除通知：`账号已删除`
- 举报通知：`收到新的举报`
- 版主长期未活动提醒
- 服务器切换为仅限邀请注册的通知
- 邮件底部的 `Email settings` 改为 `邮件设置`

涉及文件：

- `packages/backend/src/core/EmailService.ts`
- `packages/backend/src/server/api/endpoints/request-reset-password.ts`
- `packages/backend/src/server/api/endpoints/i/update-email.ts`
- `packages/backend/src/server/api/SignupApiService.ts`
- `packages/backend/src/server/api/SigninService.ts`
- `packages/backend/src/queue/processors/DeleteAccountProcessorService.ts`
- `packages/backend/src/core/AbuseReportNotificationService.ts`
- `packages/backend/src/queue/processors/CheckModeratorsActivityProcessorService.ts`
