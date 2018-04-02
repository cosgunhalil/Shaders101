// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Shaders101/BasicCutaway"
{
    Properties
    {
        _Color("Color",Color) = (1, 1, 1, 1)
        _VisibleLimit("Visible Upper Limit", vector) = (0, 0, 0, 0)
    }

	SubShader
	{      
		Pass
		{

            Cull Off

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
                float4 positionInObjectCoordinates : TEXCOORD0;  
            };

            fixed4 _Color;
            vector _VisibleLimit;

            vertexOutput vert(vertexInput input)
            {
                vertexOutput output;
                output.pos = UnityObjectToClipPos(input.vertex);
                output.positionInObjectCoordinates = input.vertex;

                return output;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                if(input.positionInObjectCoordinates.x > _VisibleLimit.x)
                {
                    discard;
                }

                if(input.positionInObjectCoordinates.y > _VisibleLimit.y)
                {
                    discard;
                }

                if(input.positionInObjectCoordinates.z > _VisibleLimit.z)
                {
                    discard;
                }

                return _Color;
            }

			ENDCG
		}
	}
}
