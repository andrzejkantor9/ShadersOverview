Shader "Mine/VertexAndFragmentShaders/ColorVertexFragment"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                float4 color: COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            //processes every vertex
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);

                // o.color.r = v.vertex.x;
                // o.color.r = (v.vertex.x + 10)/10;
                // o.color.g = (v.vertex.z + 10)/10;
                return o;
            }

            //processes every pixel
            //no z coordinate in screen space
            fixed4 frag (v2f i) : SV_Target
            {
                // fixed4 color = i.color;
                fixed4 color;
                color.r = i.vertex.x / 1000;
                color.g = i.vertex.y / 1000;
                return color;
            }
            ENDCG
        }
    }
}
