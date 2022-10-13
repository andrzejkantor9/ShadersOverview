﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraDrive : MonoBehaviour
{
    public float speed = 10.0f;
    public float rotationSpeed = 100.0f;

    void Update()
    {
        // Get the horizontal and vertical axis.
        // By default they are mapped to the arrow keys.
        // The value is in the range -1 to 1
        float translation = Input.GetAxis("Vertical") * speed;
        float rotation = Input.GetAxis("Mouse X") * rotationSpeed;
        float pitch = Input.GetAxis("Mouse Y") * rotationSpeed;

        // Make it move 10 meters per second instead of 10 meters per frame...
        translation *= Time.deltaTime;
        rotation *= Time.deltaTime;
        pitch *= Time.deltaTime;

        // Move translation along the object's z-axis
        transform.Translate(0, 0, translation);

        // Rotate around our y-axis
        transform.Rotate(Vector3.up, rotation);

        // Pitch
        transform.Rotate(Vector3.left, pitch);
    }
}
