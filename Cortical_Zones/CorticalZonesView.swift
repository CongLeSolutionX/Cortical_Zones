//
//MIT License
//
//Copyright © 2025 Cong Le
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in all
//copies or substantial portions of the Software.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//SOFTWARE.
//
//
//  CorticalZonesView.swift
//  Cortical_Zones
//
//  Created by Cong Le on 6/29/25.
//

import SwiftUI

// MARK: - Main View: CorticalZonesView

/// A SwiftUI view that visually represents the architectural zones of cortical development.
///
/// This view provides a high-level, educational visualization of the layered structure of the
/// developing cerebral wall, from the outermost Pia Mater to the innermost Ventricular Zone.
/// It uses a series of reusable `ZoneView` components to display each layer with a distinct
/// color, name, abbreviation, and description, all organized within a `ScrollView`.
///
/// ## Best Practices Followed:
/// - **Componentization:** The view is broken down into a main container (`CorticalZonesView`)
///   and a reusable component (`ZoneView`), promoting code reuse and clarity.
/// - **Descriptive Naming:** All views, properties, and constants have clear, descriptive names.
/// - **Static Data Model:** A private struct `ZoneInfo` is used to neatly model the static
///   data for each zone, making the view body cleaner and more maintainable.
/// - **Dynamic Type and Accessibility:** Uses standard SwiftUI fonts (`.headline`, `.subheadline`)
///   that respect the user's Dynamic Type settings.
/// - **Layout and Adaptability:** `ScrollView` and fluid padding ensure the view adapts well to
///   different screen sizes and orientations.
/// - **Thorough Documentation:** Each component is documented to explain its purpose and usage.
struct CorticalZonesView: View {
    
    // MARK: - Data Model
    
    /// A private data structure to hold the information for each cortical zone.
    /// This keeps the view's body clean and separates data from presentation.
    struct ZoneInfo: Identifiable {
        let id = UUID()
        let name: String
        let abbreviation: String
        let description: String
        let color: Color
    }
    
    /// An array containing the static data for all cortical zones, ordered from
    /// the outermost layer (after the Pia Mater) to the innermost.
    private let zones: [ZoneInfo] = [
        ZoneInfo(name: "Marginal Zone",
                 abbreviation: "MZ",
                 description: "The future Layer I. Home to Cajal-Retzius cells that secrete vital migration signals like Reelin.",
                 color: .blue),
        ZoneInfo(name: "Cortical Plate",
                 abbreviation: "CP",
                 description: "The destination for migrating neurons, which form layers II-VI of the neocortex in an 'inside-out' sequence.",
                 color: .purple),
        ZoneInfo(name: "Subplate",
                 abbreviation: "SP",
                 description: "A transient layer beneath the cortical plate where early synaptic connections are established, guiding thalamic axons.",
                 color: .orange),
        ZoneInfo(name: "Intermediate Zone",
                 abbreviation: "IZ",
                 description: "The future white matter. Migrating neurons pass through this zone, which is rich in axonal fibers.",
                 color: .gray),
        ZoneInfo(name: "Subventricular Zone",
                 abbreviation: "SVZ",
                 description: "A secondary progenitor zone that generates many of the neurons destined for the upper cortical layers.",
                 color: .green),
        ZoneInfo(name: "Ventricular Zone",
                 abbreviation: "VZ",
                 description: "The primary progenitor zone where neural stem cells (radial glia) divide to produce neurons.",
                 color: Color(red: 0.2, green: 0.6, blue: 0.2)) // A slightly darker green
    ]
    
    // MARK: - Body
    
    var body: some View {
        // NavigationView provides a container and can be used for a title bar if desired.
        NavigationView {
            // ScrollView ensures content is accessible on all device sizes.
            ScrollView {
                // Main vertical stack for all content.
                VStack(spacing: 12) {
                    HeaderView()
                    
                    // Display the label for the outermost boundary.
                    Text("Pia Mater (Outer Surface)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top)

                    // Iterate over the zones data model to create a view for each zone.
                    // Using ForEach with a data model is more scalable and cleaner than
                    // hardcoding each view instance in the body.
                    ForEach(zones) { zone in
                        ZoneView(zoneInfo: zone)
                    }
                    
                    // Display the label for the innermost boundary.
                    Text("Ventricle / Cerebrospinal Fluid (Innermost)")
                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.secondary)
                        .padding(.top)
                        .padding(.bottom) // Add padding at the very end.
                }
            }
            .navigationBarHidden(true) // We use a custom header instead of the default navigation bar.
        }
    }
}

// MARK: - Reusable Components

/// A view that displays the title and introductory information for the screen.
private struct HeaderView: View {
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: "brain.head.profile.fill")
                .font(.system(size: 40))
                .foregroundColor(.accentColor)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.white)
            
            Text("Architectural Zones of Cortical Development")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("A visual guide to the transient layers of the developing cerebral wall, arranged from outermost to innermost.")
                .font(.footnote)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding(.vertical)
    }
}


/// A reusable view component that displays a single architectural zone of the developing cortex.
/// It is designed to be visually distinct and informative.
private struct ZoneView: View {
    /// The data model containing all information for the zone.
    let zoneInfo: CorticalZonesView.ZoneInfo
    
    var body: some View {
        // ZStack allows layering a colored background behind the content.
        ZStack {
            // The background card shape and style.
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(zoneInfo.color.opacity(0.15))

            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .stroke(zoneInfo.color, lineWidth: 2)

            // Horizontal stack for the main content layout.
            HStack(spacing: 16) {
                // Informative content: title and description.
                VStack(alignment: .leading, spacing: 5) {
                    Text(zoneInfo.name)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text(zoneInfo.description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        // Ensures text wraps correctly without being cut off.
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Spacer()
                
                // Abbreviation visual element for quick identification.
                Text(zoneInfo.abbreviation)
                    .font(.system(size: 20, weight: .black, design: .rounded))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(zoneInfo.color.gradient)
                    .clipShape(Circle())
            }
            .padding()
        }
        .padding(.horizontal)
    }
}


// MARK: - SwiftUI Preview

/// A preview provider to display the `CorticalZonesView` in the Xcode canvas.
/// This is essential for rapid UI development and testing.
struct CorticalZonesView_Previews: PreviewProvider {
    static var previews: some View {
        CorticalZonesView()
            // Preview in both light and dark mode to check contrasts.
            .preferredColorScheme(.light)
        
        CorticalZonesView()
            .preferredColorScheme(.dark)
    }
}
