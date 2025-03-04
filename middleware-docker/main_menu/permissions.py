from rest_framework.permissions import BasePermission

class IsAuthenticatedForPOSTOnly(BasePermission):
    def has_permission(self, request, view):
        # Allow unauthenticated access to GET requests
        if request.method in ['GET', 'OPTIONS', 'HEAD']:
            return True

        # Allow authenticated access to POST requests
        if request.method == 'POST':
            return request.user and request.user.is_authenticated

        # Allow authenticated users to update or delete if they are the owner
        if request.method in ['PUT', 'PATCH', 'DELETE']:
            return request.user and request.user.is_authenticated
        
        # Deny access by default
        return False