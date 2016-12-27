#ifdef GL_ES
precision mediump float;
#else
#define lowp
#define mediump
#define highp
#endif

#pragma mapbox: define lowp vec4 color
#pragma mapbox: define lowp float blur
#pragma mapbox: define lowp float opacity

uniform sampler2D u_texture;

varying vec2 v_extrude;
varying vec2 v_tex;

void main() {
    #pragma mapbox: initialize lowp vec4 color
    #pragma mapbox: initialize lowp float blur
    #pragma mapbox: initialize lowp float opacity

		gl_FragColor = texture2D(u_texture, v_tex).a * (color * opacity);

#ifdef OVERDRAW_INSPECTOR
    gl_FragColor = vec4(1.0);
#endif
}
