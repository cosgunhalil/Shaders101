Shader "Shaders101/Transparency"
{
    Properties
    {
        _ColorFront("Front Color",Color) = (1.0, 1.0, 1.0, 1.0)
        _ColorBack("Back Color",Color) = (1.0, 1.0, 1.0, 1.0)
    }
	SubShader
	{      
		Pass
		{
             Cull Front// render back faces first
			 ZWrite Off
             Blend SrcAlpha OneMinusSrcAlpha // alpha blending

             CGPROGRAM 
     
             #pragma vertex vert 
             #pragma fragment frag

             float4 _ColorBack;

             float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
             {
                return UnityObjectToClipPos(vertexPos);
             }
     
             float4 frag(void) : COLOR 
             {
                return _ColorBack;
             }
 
            ENDCG

		}

        Pass
        {
             Cull Back // render front faces first
             ZWrite Off
             Blend SrcAlpha OneMinusSrcAlpha // alpha blending

             CGPROGRAM 
     
             #pragma vertex vert 
             #pragma fragment frag

             float4 _ColorFront;

             float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
             {
                return UnityObjectToClipPos(vertexPos);
             }
     
             float4 frag(void) : COLOR 
             {
                return _ColorFront;
             }
 
         ENDCG


        }
	}
}
