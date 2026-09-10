# chahua

自然材料拼贴海报 → 小红书文案 → 手工制作过程视频的稳定复用 Skill。

核心 Skill：`skills/chahua-pipeline/SKILL.md`

## 目标

将一次完整生产流程固定为三个可恢复阶段：

1. 当天联网选图并保存到 `D:\picture`；
2. 在 ChatGPT 中制作自然材料拼贴海报，裁出最终下半部分，并保存到 `D:\picture-output`；
3. 在 Gemini 中以最终海报为唯一视觉真值生成 9:16 手工制作纪录视频并下载归档。

## 推荐触发语

- `运行 chahua skill，只做 1 张`
- `运行 chahua skill，完整跑一遍`
- `运行 chahua skill，从制图阶段继续`
- `运行 chahua skill，从视频阶段继续`

默认只处理 1 张图。只有用户明确要求批量时才扩大处理范围。

## 目录

```text
D:\picture              原始候选/最终选中照片
D:\picture-output       最终自然材料拼贴成品
D:\picture-output\video 视频成品
```

Skill 会维护本地运行状态与选图记录，避免重复搜索、重复生成和下载错文件。
