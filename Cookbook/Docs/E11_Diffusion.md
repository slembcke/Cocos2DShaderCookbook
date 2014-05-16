#E11: Diffusion

![image](E11_Diffusion.png)

This is one of my favorite effects. It uses a noise texture to offset each pixel slightly. This produces a nice little noisy blur effect. Since it only requires a single dependent texture lookup per pixel, it's pretty cheap as a blur.

The vertex shader should look quite familiar already.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">vec2</span> u_NoiseTextureSize;

<span style="color:#881350;">uniform</span> <span style="color:#881350;">float</span> u_AnimationEnabled;
<span style="color:#881350;">uniform</span> <span style="color:#881350;">float</span> u_BlockSize;

<span style="color:#881350;">void</span> main(){
  <span style="color:#003369;">gl_Position</span> = cc_Position;
  cc_FragColor = <span style="color:#003369;">clamp</span>(cc_Color, 0.0, 1.0);
  cc_FragTexCoord1 = cc_TexCoord1;
  
  <span style="color:#881350;">vec2</span> screen01 = (0.5*<span style="color:#003369;">gl_Position</span>.x<span style="color:#881350;">y</span>/<span style="color:#003369;">gl_Position</span>.<span style="color:#881350;">w</span> + 0.5);
  cc_FragTexCoord2 = screen01*cc_ViewSizeInPixels/u_NoiseTextureSize;
  <span style="color:#881350;">vec2</span> randomAnimatedOffset = cc_Random01.x<span style="color:#881350;">y</span>*u_AnimationEnabled;
  cc_FragTexCoord2 = (uv + randomAnimatedOffset)/u_BlockSize;
}
</pre>

The fragment shader is also unsurprising.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">float</span> u_Radius;
<span style="color:#881350;">uniform</span> <span style="color:#881350;">vec2</span> u_MainTextureSize;
<span style="color:#881350;">uniform</span> <span style="color:#881350;">sampler2D</span> u_NoiseTexture;

<span style="color:#881350;">void</span> main(){
  <span style="color:#881350;">vec2</span> noise = 2.0*<span style="color:#003369;">texture2D</span>(u_NoiseTexture, cc_FragTexCoord2).x<span style="color:#881350;">y</span> - 1.0;
  <span style="color:#881350;">vec2</span> distortionOffset = u_BlurRadius*noise/u_MainTextureSize;
  
  <span style="color:#003369;">gl_FragColor</span> = cc_FragColor*<span style="color:#003369;">texture2D</span>(cc_MainTexture, cc_FragTexCoord1 + distortionOffset);
}
</pre>

One important thing to note here is that the noise texture I used has a gausian distribution. This means that the color values are more likely to be gray than white or black. If it had a uniform distribution, meaning it's just as likely to be white, gray or black, then the blur wouldn't look as good.

## Exercises:

* Try different noise textures. See how it changes the result.