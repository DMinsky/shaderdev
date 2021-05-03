Shader "Custom/BareBone"
{

    Properties
    {
        _Color ("Main Color", Color) = (1, 1, 1, 1)
    }

    Subshader
    {
        Pass
        {
            HLSLPROGRAM
            #include "UnityCG.cginc"
            
            #pragma vertex vert
            #pragma fragment frag

            struct vertInput
            {
                float4 vertex : POSITION;
            };

            struct vertOutput
            {
                float4 pos : SV_POSITION;
            };

            float4 _Color;

            vertOutput vert(vertInput v)
            {
                vertOutput o;
                o.pos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            float4 frag(vertOutput i) : SV_TARGET
            {
                return _Color;
            }

            ENDHLSL
        }

    }

    Fallback "Unlit/Color"
}
