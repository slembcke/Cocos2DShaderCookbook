# E09: Static

![image](E09_Static.png)

So this is a fun effect. Some nice static like you see on a TV screen. Since there is no `rand()` function to use in a shader we'll use a texture full of random pixels instead. Time to dive into the code.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">vec2</span> u_NoiseTextureSize;

<span style="color:#881350;">void</span> main(){
  <span style="color:#003369;">gl_Position</span> = cc_Position;
  cc_FragColor = <span style="color:#003369;">clamp</span>(cc_Color, 0.0, 1.0);
  cc_FragTexCoord1 = cc_TexCoord1;
  
  <span style="color:#881350;">vec2</span> screen01 = (0.5*<span style="color:#003369;">gl_Position</span>.x<span style="color:#881350;">y</span>/<span style="color:#003369;">gl_Position</span>.<span style="color:#881350;">w</span> + 0.5);
  cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTextureSize;
  cc_FragTexCoord2 += cc_Random01.x<span style="color:#881350;">y</span>;
}
</pre>
Another vertex shader! Woo? Boo? It starts out the same way as the default vertex shader, but what do those last three lines do?

	vec2 screen01 = (0.5*gl_Position.xy/gl_Position.w + 0.5);

In OpenGL, the `gl_Position` coordinates go from (-1, -1) for the bottom left corner of the screen to (1, 1) for the top right. This is called _clip coordinates_. This isn't quite the same as texture coordinates so we need to do a little math to put them into the [0, 1] range. So what's up with dividing by `gl_Position.w`? Well... It's complicated, and mostly required if you use 3D effects. _"Perspective divide"_ is the term to Google for if you want to know more.

	cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTextureSize;

Now that we have a [0, 1] value for the vertex relative to the screen, we can multiply that be the screen size to convert it to pixels. Fortunately, Cocos2D provides a builtin uniform for that, `cc_ViewSiveInPixels`. Since the texture was set to repeat in the Objective-C code, if we divide the pixel coordinate by the noise texture's size We now have a texture coordinate where the pixels in the texture will always line up with the screen. This might be a lot to take in, but it's a common pattern in special effect shaders and definitely something you'll want to learn.

	cc_FragTexCoord2 += cc_Random01.xy;

This last line makes the static animate. While you don't get a `rand()` function in shaders, Cocos2D provides a builtin `vec4` uniform that it fills with random numbers in the range [0, 1] each frame. We can just add this as an offset to the texture coordinate to make the static jitter around randomly. Neat. Onto the fragment shader.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">sampler2D</span> u_NoiseTexture;

<span style="color:#881350;">uniform</span> <span style="color:#881350;">float</span> u_NoiseAmount;

<span style="color:#881350;">void</span> main(){
  <span style="color:#881350;">vec4</span> textureColor = <span style="color:#003369;">texture2D</span>(cc_MainTexture, cc_FragTexCoord1);
  <span style="color:#881350;">vec4</span> noiseColor = <span style="color:#003369;">texture2D</span>(u_NoiseTexture, cc_FragTexCoord2);
  
  <span style="color:#003369;">gl_FragColor</span> = cc_FragColor*textureColor;
  <span style="color:#003369;">gl_FragColor</span>.rg<span style="color:#881350;">b</span> += (textureColor.<span style="color:#881350;">a</span>*u_NoiseAmount)*(2.0*noiseColor.rg<span style="color:#881350;">b</span> - 1.0);
}
</pre>

Nothing fancy here. Note that the noise value is converted to the [-1, 1] range and premultiplied by the texture's alpha.

## Excercises:

* Try making the static grayscale instead of colored.
* Try making the static scroll instead of jumping around randomly.