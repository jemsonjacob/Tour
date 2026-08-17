import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourexplorer/core/custom/app_colors.dart';
import 'package:tourexplorer/core/custom/app_sizes.dart';
import 'package:tourexplorer/core/custom/app_text_style.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/presentation/bloc/auth_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              //  print('Current Auth State: $state');
              if (state is AuthSuccess) {
                return _buildProfile(context, state.user);
              }

              if (state is AuthLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return const Center(child: Text('User information unavailable'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserEntity user) {
    return ListView(
      padding: const EdgeInsets.all(AppSizes.md),
      children: [
        Text('Profile', style: AppTextStyles.heading1),
        const SizedBox(height: 4),
        const Text(
          'Manage your account',
          style: TextStyle(color: AppColors.greyColor, fontSize: 14),
        ),
        const SizedBox(height: AppSizes.xl),
        _buildProfileHeader(user),
        const SizedBox(height: 12),
        const AboutListTile(
          icon: Icon(Icons.info_outline),
          applicationName: "Travel Explore",
          applicationVersion: "1.0.0",
          applicationLegalese: "© 2026 Jemson Jacob",
        ),
        const SizedBox(height: AppSizes.xl),
        _buildLogoutButton(context),
      ],
    );
  }

  Widget _buildProfileHeader(UserEntity user) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor.withAlpha(15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 42,
            backgroundImage: user.photoUrl != null && user.photoUrl!.isNotEmpty
                ? NetworkImage(user.photoUrl!)
                : null,
            child: user.photoUrl == null || user.photoUrl!.isEmpty
                ? const Icon(Icons.person, size: 42)
                : null,
          ),

          const SizedBox(height: 14),

          Text(
            user.name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.backgroundColor,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            user.email,
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      tileColor: AppColors.greyColor.withAlpha(50),
      leading: CircleAvatar(
        backgroundColor: AppColors.backgroundColor.withAlpha(20),
        child: Icon(icon, color: AppColors.backgroundColor),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: AppColors.backgroundColor,
        ),
      ),
      subtitle: Text(subtitle, style: TextStyle(color: AppColors.greyColor)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: () {
          _showLogoutDialog(context);
        },
        icon: const Icon(Icons.logout, color: AppColors.whiteColor),
        label: const Text(
          'Logout',
          style: TextStyle(color: AppColors.whiteColor),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(dialogContext);

                context.read<AuthBloc>().add(const AuthLogoutEvent());
              },
              child: const Text(
                'Logout',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        );
      },
    );
  }
}
