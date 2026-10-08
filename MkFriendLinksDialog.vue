<!--
SPDX-FileCopyrightText: syuilo and misskey-project
SPDX-License-Identifier: AGPL-3.0-only
-->

<template>
<MkModal ref="modal" :preferType="'dialog'" :zPriority="'middle'" @closed="emit('closed')">
	<div :class="$style.root">
		<div :class="$style.header">
			<div :class="$style.headerTitle">
				<i class="ti ti-link" :class="$style.icon"></i>
				<span :class="$style.title">友情链接</span>
			</div>
			<button class="_button _acrylic" :class="$style.close" type="button" @click="modal?.close()">
				<i class="ti ti-x"></i>
			</button>
		</div>
		<div :class="$style.body">
			<a
				:class="$style.link"
				href="https://ooon.top/"
				target="_blank"
				rel="noopener noreferrer"
			>
				<span :class="$style.name">心墙</span>
				<span :class="$style.url">https://ooon.top/</span>
			</a>
		</div>
	</div>
</MkModal>
</template>

<script lang="ts" setup>
import { useTemplateRef } from 'vue';
import MkModal from '@/components/MkModal.vue';
const emit = defineEmits<{
	(ev: 'closed'): void;
}>();

const modal = useTemplateRef('modal');
</script>

<style lang="scss" module>
.root {
	width: min(420px, calc(100vw - 32px));
	overflow: hidden;
	background: var(--MI_THEME-panel);
	border-radius: var(--MI-radius);
	box-shadow: 0 12px 32px rgb(0 0 0 / 25%);
}

.header {
	display: flex;
	align-items: center;
	justify-content: space-between;
	gap: 10px;
	padding: 12px 12px 12px 20px;
	border-bottom: 1px solid var(--MI_THEME-divider);
	font-weight: bold;
}

.headerTitle {
	display: flex;
	align-items: center;
	gap: 10px;
}

.close {
	width: 32px;
	height: 32px;
	border-radius: 8px;
	font-size: 18px;
}

.icon {
	color: var(--MI_THEME-accent);
	font-size: 1.2em;
}

.title {
	font-size: 1.1em;
}

.body {
	padding: 16px;
}

.link {
	display: flex;
	flex-direction: column;
	gap: 4px;
	padding: 14px 16px;
	color: inherit;
	text-decoration: none;
	background: color(from var(--MI_THEME-fg) srgb r g b / 0.05);
	border-radius: var(--MI-radius);
	transition: background 0.2s ease;
}

.link:hover {
	background: color(from var(--MI_THEME-fg) srgb r g b / 0.1);
}

.name {
	font-weight: bold;
	color: var(--MI_THEME-accent);
}

.url {
	font-size: 0.9em;
	opacity: 0.7;
	word-break: break-all;
}

</style>