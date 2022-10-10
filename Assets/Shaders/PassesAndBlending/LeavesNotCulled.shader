Shader "Mine/PassesAndBlending/LeavesNotCulled"
{
    Properties
    {
        _MainTexture ("Main Texture", 2D) = "black" {}
    }

    SubShader
    {
        Tags
        {
            "Queue"="Transparent"
        }
        
        Blend SrcAlpha OneMinusSrcAlpha

        Cull Off

        Pass
        {
            SetTexture [_MainTexture] {combine texture}
        }
    }

    FallBack "Diffuse"
}