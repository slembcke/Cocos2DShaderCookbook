# E10: Water

![image](E10_Water.png)

Here's a practical animated water effect.

It's works like the earlier Sprite Distort example, but instead of using a trig function to distort the texture coordinates, we'll use colors out of another texture. Similar to how GLSL doesn't have special vectors for colors and positions, textures aren't really special either. You can treat a texture as containing colors, offsets, or a function lookup table. It's all just numbers to OpenGL.

Code time! We'll start with the vertex shader.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">vec2</span> u_NoiseTextureSize;

<span style="color:#881350;">void</span> main(){
  <span style="color:#003369;">gl_Position</span> = cc_Position;
  cc_FragColor = <span style="color:#003369;">clamp</span>(cc_Color, 0.0, 1.0);
  cc_FragTexCoord1 = cc_TexCoord1;
  cc_FragTexCoord2 = cc_TexCoord2;
  
  <span style="color:#881350;">vec2</span> distortionScroll = <span style="color:#881350;">vec2</span>(cc_Time[0], 0.0);
  <span style="color:#881350;">vec2</span> screen01 = (0.5*<span style="color:#003369;">gl_Position</span>.x<span style="color:#881350;">y</span>/<span style="color:#003369;">gl_Position</span>.<span style="color:#881350;">w</span> + 0.5);
  cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTextureSize + distortionScroll;
}
</pre>

This should look familiar. It's not too different than the last one. On to the fragment shader.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">sampler2D</span> u_NoiseTexture;
<span style="color:#881350;">uniform</span> <span style="color:#881350;">sampler2D</span> u_CausticTexture;

<span style="color:#881350;">void</span> main(){
  <span style="color:#881350;">vec2</span> distortion = 2.0*<span style="color:#003369;">texture2D</span>(u_NoiseTexture, cc_FragTexCoord2).x<span style="color:#881350;">y</span> - 1.0;
  <span style="color:#881350;">vec2</span> distortionOffset = distortion*0.05;
  
  <span style="color:#003369;">gl_FragColor</span> = cc_FragColor*<span style="color:#003369;">texture2D</span>(cc_MainTexture, cc_FragTexCoord1 + distortionOffset);
  <span style="color:#003369;">gl_FragColor</span> += 0.5*<span style="color:#003369;">texture2D</span>(u_CausticTexture, cc_FragTexCoord1 - distortionOffset);
}
</pre>

Nothing particularly new here, just new combinations.

## Exercises:

* Try experimenting with the noise texture. See if you can make different kinds of waves.