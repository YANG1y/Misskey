#version 300 es
precision mediump float;

/*
 * SPDX-FileCopyrightText: syuilo and misskey-project
 * SPDX-License-Identifier: AGPL-3.0-only
 */

in vec4 v_color;
in float v_rotation;
uniform sampler2D u_texture;
uniform float u_autumn;
out vec4 out_color;

void main() {
	vec2 rotated = vec2(
		cos(v_rotation) * (gl_PointCoord.x - 0.5) + sin(v_rotation) * (gl_PointCoord.y - 0.5) + 0.5,
		cos(v_rotation) * (gl_PointCoord.y - 0.5) - sin(v_rotation) * (gl_PointCoord.x - 0.5) + 0.5
	);

	vec4 snowflake = texture(u_texture, rotated);
	vec2 leaf = gl_PointCoord - 0.5;
	float angle = atan(leaf.y, leaf.x);
	float distanceFromCenter = length(leaf);
	// Five pointed lobes with deep valleys between them, giving a maple-leaf silhouette.
	float lobeRadius = 0.205 + 0.115 * max(cos(angle * 5.0), -0.55);
	float pointedLeaf = 1.0 - smoothstep(lobeRadius - 0.018, lobeRadius + 0.018, distanceFromCenter);
	float stem = (1.0 - smoothstep(0.055, 0.075, abs(leaf.x))) * (1.0 - smoothstep(0.20, 0.24, -leaf.y));
	float vein = 1.0 - smoothstep(0.018, 0.035, abs(leaf.y + leaf.x * 0.18));
	float autumnAlpha = max(pointedLeaf, stem) * (0.68 + vein * 0.32);
	vec4 autumnLeaf = vec4(vec3(0.95, 0.28, 0.025), autumnAlpha);
	vec4 particle = mix(snowflake, autumnLeaf, u_autumn);

	out_color = vec4(particle.rgb * v_color.xyz, particle.a * v_color.a);
}