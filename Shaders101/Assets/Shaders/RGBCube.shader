// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/RGBCube"
{
	SubShader
	{      
		Pass
		{
			CGPROGRAM
			#pragma vertex vert //define vertex function
			#pragma fragment frag //define frag function
             
            struct vertexOutput 
            {
                float4 pos : SV_POSITION;
                float4 col : TEXCOORD0;
            };

            // vertex shader 
            vertexOutput vert(float4 vertexPos : POSITION) 
            {
                vertexOutput output;
     
                output.pos =  UnityObjectToClipPos(vertexPos);
                output.col = vertexPos + float4(0.5, 0.5, 0.5, 0.0);
                 
                return output;
            }

            // fragment shader
            float4 frag(vertexOutput input) : COLOR 
            {
               return input.col; 
            }

            ENDCG
		}
	}
}
