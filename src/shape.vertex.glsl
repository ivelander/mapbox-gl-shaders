#ifdef GL_ES
precision highp float;
#else
#define lowp
#define mediump
#define highp
#endif

uniform mat4 u_matrix;
uniform vec2 u_extrude_scale;
uniform vec2 u_texsize;

attribute vec2 a_pos;
attribute vec2 a_offset;
attribute vec2 a_texture_pos;

#pragma mapbox: define lowp vec4 color
#pragma mapbox: define mediump float scale
#pragma mapbox: define lowp float blur
#pragma mapbox: define lowp float opacity

varying vec2 v_extrude;
varying vec2 v_tex;

void main(void) {
    #pragma mapbox: initialize lowp vec4 color
    #pragma mapbox: initialize mediump float scale
    #pragma mapbox: initialize lowp float blur
    #pragma mapbox: initialize lowp float opacity

		vec2 a_tex = a_texture_pos.xy;

		vec2 extrude = (u_extrude_scale * scale) * (a_offset / 64.0);

		gl_Position = u_matrix * vec4(a_pos, 0, 1) + vec4(extrude, 0, 0);

		v_tex = a_tex / u_texsize;
}
