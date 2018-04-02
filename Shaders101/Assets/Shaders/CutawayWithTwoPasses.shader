// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/CutawayWithTwoPasses"
{

    Properties
    {
        _ColorCullBack("Cull Back Color",Color) = (1, 1, 1, 1)
        _ColorCullFront("Cull Front Color",Color) = (0, 0, 0, 0)
        _CullLimit("Cull Limit", vector) = (0, 0, 0, 0)
    }

	SubShader
	{
 
        //execute earlier than the second pass
		Pass
		{
            Cull Front

			CGPROGRAM
            
			#pragma vertex vert
			#pragma fragment frag

             struct vertexInput 
             {
                 float4 vertex : POSITION;
             };

             struct vertexOutput 
             {
                float4 pos : SV_POSITION;
                float4 posInObjectCoords : TEXCOORD0;
             };

             fixed4 _ColorCullFront;
             vector _CullLimit;
     
             vertexOutput vert(vertexInput input) 
             {
                vertexOutput output;
     
                output.pos =  UnityObjectToClipPos(input.vertex);
                output.posInObjectCoords = input.vertex; 
     
                return output;
             }
     
             float4 frag(vertexOutput input) : COLOR 
             {
                if (input.posInObjectCoords.x > _CullLimit.x) 
                {
                   discard; 
                }

                if (input.posInObjectCoords.y > _CullLimit.y) 
                {
                   discard; 
                }

                if (input.posInObjectCoords.z > _CullLimit.z) 
                {
                   discard; 
                }

                return _ColorCullFront;
             }

			ENDCG
		}

        Pass
        {
            Cull Back 

            CGPROGRAM 
 
             #pragma vertex vert  
             #pragma fragment frag 
     
             struct vertexInput 
             {
                float4 vertex : POSITION;
             };

             struct vertexOutput 
             {
                float4 pos : SV_POSITION;
                float4 posInObjectCoords : TEXCOORD0;
             };

             fixed4 _ColorCullBack;
             vector _CullLimit;
     
             vertexOutput vert(vertexInput input) 
             {
                vertexOutput output;
     
                output.pos =  UnityObjectToClipPos(input.vertex);
                output.posInObjectCoords = input.vertex; 
     
                return output;
             }
     
             float4 frag(vertexOutput input) : COLOR 
             {
                if (input.posInObjectCoords.x > _CullLimit.x) 
                {
                   discard; 
                }

                if (input.posInObjectCoords.y > _CullLimit.y) 
                {
                   discard; 
                }

                if (input.posInObjectCoords.z > _CullLimit.z) 
                {
                   discard; 
                }
                return _ColorCullBack; 
             }
 
            ENDCG  
        }
	}
}
