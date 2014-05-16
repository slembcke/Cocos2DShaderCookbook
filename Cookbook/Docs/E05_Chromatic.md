# E05: Chromatic
![image](E05_Chromatic.png)

Here's a fun effect you see in games sometimes that makes it look like you are looking through a prism. It works by sampling the texture multiple times at slightly different places and then combines them back together.

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">void</span> main(){
  <span style="color:#881350;">float</span> t = cc_Time[0];
  <span style="color:#881350;">vec2</span> uv = cc_FragTexCoord1;
  <span style="color:#881350;">float</span> wave = 0.01;
  
  <span style="color:#236e25;"><em>// Sample the same texture several times at different locations.
</em></span>  <span style="color:#881350;">vec4</span> r = <span style="color:#003369;">texture2D</span>(cc_MainTexture, uv + <span style="color:#881350;">vec2</span>(wave*<span style="color:#003369;">sin</span>(1.0*t + uv.<span style="color:#881350;">y</span>*5.0), 0.0));
  <span style="color:#881350;">vec4</span> g = <span style="color:#003369;">texture2D</span>(cc_MainTexture, uv + <span style="color:#881350;">vec2</span>(wave*<span style="color:#003369;">sin</span>(1.3*t + uv.<span style="color:#881350;">y</span>*5.0), 0.0));
  <span style="color:#881350;">vec4</span> b = <span style="color:#003369;">texture2D</span>(cc_MainTexture, uv + <span style="color:#881350;">vec2</span>(wave*<span style="color:#003369;">sin</span>(1.6*t + uv.<span style="color:#881350;">y</span>*5.0), 0.0));
  
  <span style="color:#236e25;"><em>// Combine the channels, average the alpha values.
</em></span>  <span style="color:#003369;">gl_FragColor</span> = <span style="color:#881350;">vec4</span>(r.<span style="color:#881350;">r</span>, g.<span style="color:#881350;">g</span>, b.<span style="color:#881350;">b</span>, (r.<span style="color:#881350;">a</span> + b.<span style="color:#881350;">a</span> + g.<span style="color:#881350;">a</span>)/3.0);
}
</pre>

## Exercises

* Experiment with other distortion patterns.
* See if you can figure out how to do more than just three colors/samples.
* Are there other ways to combine the colors together?
