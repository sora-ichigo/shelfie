const IMAGEKIT_DOMAIN = "ik.imagekit.io";
const DEFAULT_AVATAR_SIZE = 256;

export interface TransformOptions {
  width?: number;
  height?: number;
}

export function transformImageKitUrl(
  url: string | null | undefined,
  options: TransformOptions = {},
): string | null {
  if (!url) return null;
  if (!isImageKitUrl(url)) return url;

  const width = options.width ?? DEFAULT_AVATAR_SIZE;
  const height = options.height ?? DEFAULT_AVATAR_SIZE;

  const transformations = `tr=w-${width},h-${height},q-100,f-auto`;

  const uri = new URL(url);
  uri.search = transformations;

  return uri.toString();
}

function isImageKitUrl(url: string): boolean {
  try {
    const uri = new URL(url);
    return uri.host.includes(IMAGEKIT_DOMAIN);
  } catch {
    return false;
  }
}
