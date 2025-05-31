// import 'dart:math' as math;
// import 'package:flutter/material.dart';
// import 'package:portfolio_2025/app/tech/presentation/widgets/tech_image_widget.dart';
// import 'package:portfolio_2025/core/common/widgets/pages_header.dart';

// class TechNode {
//   final String image;
//   final String title;
//   Offset position;
//   Offset originalPosition;
//   final List<int> connections;
//   bool isDragging;

//   TechNode({
//     required this.image,
//     required this.title,
//     required this.position,
//     this.connections = const [],
//     this.isDragging = false,
//   }) : originalPosition = position;
// }

// class DTechPage extends StatefulWidget {
//   const DTechPage({super.key});

//   @override
//   State<DTechPage> createState() => _DTechPageState();
// }

// class _DTechPageState extends State<DTechPage> with TickerProviderStateMixin {
//   late List<TechNode> techNodes;
//   late AnimationController _connectionAnimationController;
//   late AnimationController _returnAnimationController;
//   late Animation<double> _connectionAnimation;
//   int? draggedNodeIndex;

//   @override
//   void initState() {
//     super.initState();

//     _connectionAnimationController = AnimationController(
//       duration: const Duration(seconds: 3),
//       vsync: this,
//     )..repeat();

//     _returnAnimationController = AnimationController(
//       duration: const Duration(milliseconds: 800),
//       vsync: this,
//     );

//     _connectionAnimation = Tween<double>(
//       begin: 0.0,
//       end: 1.0,
//     ).animate(CurvedAnimation(
//       parent: _connectionAnimationController,
//       curve: Curves.easeInOut,
//     ));

//     _initializeTechNodes();
//   }

//   void _initializeTechNodes() {
//     // Define the tech items with their connections (indices of connected nodes)
//     final techData = [
//       {
//         'image': 'assets/tech/flutter.png',
//         'title': 'Flutter',
//         'connections': [1, 2, 5]
//       },
//       {
//         'image': 'assets/tech/kotlin.png',
//         'title': 'Kotlin',
//         'connections': [0, 2, 8]
//       },
//       {
//         'image': 'assets/tech/js.webp',
//         'title': 'JavaScript',
//         'connections': [0, 1, 3, 4]
//       },
//       {
//         'image': 'assets/tech/node.webp',
//         'title': 'Node.js',
//         'connections': [2, 4, 6]
//       },
//       {
//         'image': 'assets/tech/api.png',
//         'title': 'REST APIs',
//         'connections': [2, 3, 5, 6]
//       },
//       {
//         'image': 'assets/tech/firebase.png',
//         'title': 'Firebase',
//         'connections': [0, 4, 7]
//       },
//       {
//         'image': 'assets/tech/supabase.png',
//         'title': 'Supabase',
//         'connections': [3, 4, 7]
//       },
//       {
//         'image': 'assets/tech/appwrite.webp',
//         'title': 'App-Write',
//         'connections': [5, 6, 8]
//       },
//       {
//         'image': 'assets/tech/github.png',
//         'title': 'GitHub',
//         'connections': [1, 7]
//       },
//     ];

//     techNodes = [];
//     for (int i = 0; i < techData.length; i++) {
//       techNodes.add(TechNode(
//         image: techData[i]['image'] as String,
//         title: techData[i]['title'] as String,
//         position: const Offset(0, 0), // Will be calculated in build
//         connections: techData[i]['connections'] as List<int>,
//       ));
//     }
//   }

//   void _calculateNodePositions(Size containerSize) {
//     // Create a circular/tree-like arrangement with increased spacing
//     final center = Offset(containerSize.width / 2, containerSize.height / 2);
//     // Increased radius for more spacing between nodes
//     final radius = math.min(containerSize.width, containerSize.height) * 0.45;

//     // Central node (Flutter)
//     techNodes[0].position = center;
//     techNodes[0].originalPosition = center;

//     // Create multiple rings/layers for better distribution
//     final innerRadius = radius * 0.6;
//     final outerRadius = radius;

//     // Arrange nodes in multiple concentric circles for better spacing
//     for (int i = 1; i < techNodes.length; i++) {
//       double nodeRadius;
//       double angleOffset = 0;

//       // Distribute nodes across inner and outer rings
//       if (i <= 4) {
//         // Inner ring (first 4 nodes)
//         nodeRadius = innerRadius;
//         final angle = (2 * math.pi * (i - 1)) / 4;
//         final x = center.dx + nodeRadius * math.cos(angle);
//         final y = center.dy + nodeRadius * math.sin(angle);

//         if (!techNodes[i].isDragging) {
//           techNodes[i].position = Offset(x, y);
//           techNodes[i].originalPosition = Offset(x, y);
//         }
//       } else {
//         // Outer ring (remaining nodes)
//         nodeRadius = outerRadius;
//         angleOffset = math.pi / 8; // Offset for outer ring
//         final angle =
//             (2 * math.pi * (i - 5)) / (techNodes.length - 5) + angleOffset;
//         final x = center.dx + nodeRadius * math.cos(angle);
//         final y = center.dy + nodeRadius * math.sin(angle);

//         if (!techNodes[i].isDragging) {
//           techNodes[i].position = Offset(x, y);
//           techNodes[i].originalPosition = Offset(x, y);
//         }
//       }
//     }
//   }

//   void _startReturnAnimation(int nodeIndex) {
//     final node = techNodes[nodeIndex];
//     final startPosition = node.position;
//     final endPosition = node.originalPosition;

//     _returnAnimationController.reset();

//     final animation = Tween<Offset>(
//       begin: startPosition,
//       end: endPosition,
//     ).animate(CurvedAnimation(
//       parent: _returnAnimationController,
//       curve: Curves.elasticOut,
//     ));

//     animation.addListener(() {
//       setState(() {
//         techNodes[nodeIndex].position = animation.value;
//       });
//     });

//     _returnAnimationController.forward().then((_) {
//       setState(() {
//         techNodes[nodeIndex].isDragging = false;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _connectionAnimationController.dispose();
//     _returnAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       padding: const EdgeInsets.only(left: 30, right: 30, bottom: 60),
//       child: Column(
//         spacing: 60,
//         mainAxisSize: MainAxisSize.min,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const PagesHeader(title: 'Tech stack'),
//           LayoutBuilder(
//             builder: (context, constraints) {
//               final containerSize = Size(
//                 constraints.maxWidth,
//                 // Increased height for better spacing
//                 math.max(700, constraints.maxWidth * 0.8),
//               );

//               _calculateNodePositions(containerSize);

//               return Container(
//                 width: containerSize.width,
//                 height: containerSize.height,
//                 child: Stack(
//                   children: [
//                     // Draw connections
//                     AnimatedBuilder(
//                       animation: _connectionAnimation,
//                       builder: (context, child) {
//                         return CustomPaint(
//                           size: containerSize,
//                           painter: ConnectionPainter(
//                             nodes: techNodes,
//                             animationValue: _connectionAnimation.value,
//                           ),
//                         );
//                       },
//                     ),

//                     // Draw nodes
//                     ...techNodes.asMap().entries.map((entry) {
//                       final index = entry.key;
//                       final node = entry.value;

//                       return Positioned(
//                         left:
//                             node.position.dx - 50, // Adjusted for widget center
//                         top:
//                             node.position.dy - 40, // Adjusted for widget center
//                         child: GestureDetector(
//                           onPanStart: (details) {
//                             setState(() {
//                               draggedNodeIndex = index;
//                               techNodes[index].isDragging = true;
//                             });
//                           },
//                           onPanUpdate: (details) {
//                             setState(() {
//                               final newPosition = node.position + details.delta;
//                               // Keep within bounds with more padding
//                               final clampedX = newPosition.dx
//                                   .clamp(60.0, containerSize.width - 60);
//                               final clampedY = newPosition.dy
//                                   .clamp(50.0, containerSize.height - 50);
//                               techNodes[index].position =
//                                   Offset(clampedX, clampedY);
//                             });
//                           },
//                           onPanEnd: (details) {
//                             _startReturnAnimation(index);
//                             draggedNodeIndex = null;
//                           },
//                           child: AnimatedScale(
//                             scale: node.isDragging ? 1.3 : 1.0,
//                             duration: const Duration(milliseconds: 200),
//                             child: TechImageWidget(
//                               image: node.image,
//                               title: node.title,
//                             ),
//                           ),
//                         ),
//                       );
//                     }).toList(),

//                     // Add floating particles for visual enhancement
//                     ...List.generate(
//                         15, // Reduced particle count for cleaner look
//                         (index) =>
//                             _buildFloatingParticle(containerSize, index)),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFloatingParticle(Size containerSize, int index) {
//     return AnimatedBuilder(
//       animation: _connectionAnimationController,
//       builder: (context, child) {
//         final offset =
//             (_connectionAnimationController.value + index * 0.15) % 1.0;
//         final x = (containerSize.width * offset) % containerSize.width;
//         final y = containerSize.height * 0.5 +
//             40 * math.sin(offset * 2 * math.pi + index);

//         return Positioned(
//           left: x,
//           top: y,
//           child: Container(
//             width: 4,
//             height: 4,
//             decoration: BoxDecoration(
//               color: Colors.blue.withOpacity(0.4),
//               shape: BoxShape.circle,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// class ConnectionPainter extends CustomPainter {
//   final List<TechNode> nodes;
//   final double animationValue;

//   ConnectionPainter({
//     required this.nodes,
//     required this.animationValue,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = Colors.blue.withOpacity(0.4)
//       ..strokeWidth = 2.5
//       ..style = PaintingStyle.stroke;

//     final glowPaint = Paint()
//       ..color = Colors.blue.withOpacity(0.15)
//       ..strokeWidth = 8.0
//       ..style = PaintingStyle.stroke;

//     final particlePaint = Paint()
//       ..color = Colors.blue.withOpacity(0.9)
//       ..style = PaintingStyle.fill;

//     // Draw connections between nodes
//     for (int i = 0; i < nodes.length; i++) {
//       final node = nodes[i];

//       for (int connectionIndex in node.connections) {
//         if (connectionIndex < nodes.length) {
//           final connectedNode = nodes[connectionIndex];

//           // Draw glow effect
//           canvas.drawLine(node.position, connectedNode.position, glowPaint);

//           // Draw main connection line
//           canvas.drawLine(node.position, connectedNode.position, paint);

//           // Draw animated particles along the connection
//           final direction = connectedNode.position - node.position;
//           final distance = direction.distance;

//           if (distance > 0) {
//             final normalizedDirection = direction / distance;

//             // Multiple particles per connection with better spacing
//             for (int j = 0; j < 2; j++) {
//               final particleOffset = (animationValue + j * 0.5) % 1.0;
//               final particlePosition = node.position +
//                   (normalizedDirection * distance * particleOffset);

//               canvas.drawCircle(particlePosition, 2.5, particlePaint);
//             }
//           }
//         }
//       }
//     }

//     // Draw pulsing effect around dragged node
//     for (int i = 0; i < nodes.length; i++) {
//       if (nodes[i].isDragging) {
//         final pulsePaint = Paint()
//           ..color = Colors.blue
//               .withOpacity(0.3 + 0.4 * math.sin(animationValue * 4 * math.pi))
//           ..strokeWidth = 5.0
//           ..style = PaintingStyle.stroke;

//         canvas.drawCircle(nodes[i].position, 70.0, pulsePaint);

//         // Additional inner pulse
//         final innerPulsePaint = Paint()
//           ..color = Colors.blue
//               .withOpacity(0.1 + 0.2 * math.sin(animationValue * 6 * math.pi))
//           ..strokeWidth = 3.0
//           ..style = PaintingStyle.stroke;

//         canvas.drawCircle(nodes[i].position, 50.0, innerPulsePaint);
//       }
//     }
//   }

//   @override
//   bool shouldRepaint(ConnectionPainter oldDelegate) {
//     return oldDelegate.animationValue != animationValue ||
//         oldDelegate.nodes != nodes;
//   }
// }
