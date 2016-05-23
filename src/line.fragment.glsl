#ifndef MAPBOX_GL_JS
uniform vec2 u_linewidth;
uniform vec4 u_color;
#else
precision mediump float;

uniform lowp vec4 u_color;
uniform lowp float u_opacity;
#endif
uniform float u_blur;

varying vec2 v_normal;
#ifdef MAPBOX_GL_JS
varying vec2 v_linewidth;
#endif
varying float v_gamma_scale;

void main() {
    // Calculate the distance of the pixel from the line in pixels.
#ifndef MAPBOX_GL_JS
    float dist = length(v_normal) * u_linewidth.s;
#else
    float dist = length(v_normal) * v_linewidth.s;
#endif

    // Calculate the antialiasing fade factor. This is either when fading in
    // the line in case of an offset line (v_linewidth.t) or when fading out
    // (v_linewidth.s)
    float blur = u_blur * v_gamma_scale;
#ifndef MAPBOX_GL_JS
    float alpha = clamp(min(dist - (u_linewidth.t - blur), u_linewidth.s - dist) / blur, 0.0, 1.0);
#else
    float alpha = clamp(min(dist - (v_linewidth.t - blur), v_linewidth.s - dist) / blur, 0.0, 1.0);

    gl_FragColor = u_color * (alpha * u_opacity);
#endif

#ifndef MAPBOX_GL_JS
    gl_FragColor = u_color * alpha;
#else
#ifdef OVERDRAW_INSPECTOR
    gl_FragColor = vec4(1.0);
#endif
#endif
}