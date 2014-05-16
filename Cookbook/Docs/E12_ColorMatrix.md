# E12: Color Matrix

![image](E12_ColorMatrix.png)

Have you ever wanted to have color adjustments in Cocos2D like you do in PhotoShop? Some way to adjust the hue, saturation, brightness, contrast, or exposure of a sprite on the fly?

Well it turns out that it's really quite simple to do with a shader:

<pre style="text-align:left;color:#000000; background-color:#ffffff; border:solid black 1px; padding:0.5em 1em 0.5em 1em; overflow:auto;font-size:small; font-family:monospace; "><span style="color:#881350;">uniform</span> <span style="color:#881350;">mat4</span> u_ColorMatrix;

<span style="color:#881350;">void</span> main(){
  <span style="color:#003369;">gl_FragColor</span> = u_ColorMatrix*<span style="color:#003369;">texture2D</span>(cc_MainTexture, cc_FragTexCoord1);
}
</pre>

You can use transformation matrices to rotate or scale sprites. Since colors are just vectors, it makes just as much sense to use matrices on colors. The catch is of course finding the right matrix to apply. There are some [good examples](http://www.graficaobscura.com/matrix/) online.

Take a look at the Objective-C code for this example to see how the matrices are made.

## Exercises:

* See if you can find any more interesting color matrices.