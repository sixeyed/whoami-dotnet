FROM mcr.microsoft.com/dotnet/core/sdk:3.0 AS builder

WORKDIR /src/whoami
COPY src/whoami/whoami.csproj .
RUN dotnet restore

COPY src /src
RUN dotnet publish -c Release -o /app whoami.csproj

# app
FROM mcr.microsoft.com/dotnet/core/aspnet:3.0

EXPOSE 80
ENTRYPOINT ["dotnet", "/app/whoami.dll"]

COPY --from=builder /app /app